# Multi-stage Dockerfile for the geoparsing Jupyter environment.
# The image is built against Irchel Geoparser 0.6.2.
FROM python:3.13-slim AS builder

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Set working directory
WORKDIR /app

# Copy Poetry configuration
COPY pyproject.toml ./

# Configure Poetry to not create virtual environments (we're already in a container)
RUN poetry config virtualenvs.create false

# Install Python dependencies
RUN poetry install --no-root --no-interaction --no-ansi

# Build JupyterLab assets
RUN jupyter lab build

# spaCy models used by the notebooks.
# en_core_web_sm: contemporary English captions in GeoparsingDemo.
# en_core_web_trf: nineteenth-century prose in MappingTextsDemo.
# xx_sent_ud_sm: sentence splitting inside the resolver.
RUN python -m spacy download en_core_web_sm && \
    python -m spacy download en_core_web_trf && \
    python -m spacy download xx_sent_ud_sm

# Cache the resolver model so the first notebook run does not download it.
ENV HF_HOME=/opt/cache/huggingface \
    HUGGINGFACE_HUB_CACHE=/opt/cache/huggingface/hub \
    SENTENCE_TRANSFORMERS_HOME=/opt/cache/sentence-transformers
RUN python -c "from sentence_transformers import SentenceTransformer; SentenceTransformer('dguzh/geo-all-MiniLM-L6-v2')"

# Install the GeoNames gazetteer.
# The build needs about 31 GB free while the artifact is compiled.
# The installed file is about 10 GB, with 13 million features.
# `download` was renamed to `install` in Geoparser 0.4.0; the old command now exits.
RUN echo "Installing GeoNames gazetteer (this may take 10-20 minutes)..." && \
    python -m geoparser install geonames && \
    echo "GeoNames installed successfully!"

# Final stage
FROM python:3.13-slim

# Install system dependencies for runtime
RUN apt-get update && apt-get install -y \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Copy Python packages from builder
COPY --from=builder /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy JupyterLab built assets from builder
COPY --from=builder /usr/local/share/jupyter /usr/local/share/jupyter

# Resolver model cache
ENV HF_HOME=/opt/cache/huggingface \
    HUGGINGFACE_HUB_CACHE=/opt/cache/huggingface/hub \
    SENTENCE_TRANSFORMERS_HOME=/opt/cache/sentence-transformers
COPY --from=builder /opt/cache /opt/cache

# Gazetteer artifacts live in the application data directory.
# Geoparser 0.5+ stores each gazetteer as one SQLite file under gazetteers/.
COPY --from=builder /root/.local/share/geoparser /root/.local/share/geoparser

# Set working directory
WORKDIR /workspace

# Copy notebooks and data from notebooks directory
COPY notebooks/GeoparsingDemo.ipynb ./
COPY notebooks/MappingTextsDemo.ipynb ./
COPY notebooks/data/ ./data/

# Expose JupyterLab port
EXPOSE 8888

# Run JupyterLab without authentication for easy access
# Users can access at http://localhost:8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--IdentityProvider.token=''", "--ServerApp.password=''", "--ServerApp.disable_check_xsrf=True"]
