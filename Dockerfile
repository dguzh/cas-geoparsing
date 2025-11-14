# Multi-stage Dockerfile for Geoparsing Jupyter Environment
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

# Download spaCy models
RUN python -m spacy download en_core_web_sm && \
    python -m spacy download xx_sent_ud_sm

# Download gazetteer (this will take a while but only happens during build)
# GeoNames: ~13GB, takes 15-30 minutes
RUN echo "Downloading GeoNames gazetteer (this may take 15-30 minutes)..." && \
    python -m geoparser download geonames && \
    echo "GeoNames downloaded successfully!"

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

# Copy gazetteer database from builder
# This is stored in the user's app data directory
COPY --from=builder /root/.local/share/geoparser /root/.local/share/geoparser

# Set working directory
WORKDIR /workspace

# Copy notebooks and data
COPY GeoparsingDemo.ipynb ./
COPY MappingTextsDemo.ipynb ./
COPY data/ ./data/

# Expose JupyterLab port
EXPOSE 8888

# Run JupyterLab without authentication for easy access
# Users can access at http://localhost:8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--IdentityProvider.token=''", "--ServerApp.password=''", "--ServerApp.disable_check_xsrf=True"]

