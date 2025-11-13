# Geoparsing Demo: Extracting Locations from Text

This Jupyter notebook demonstrates **geoparsing** - automatically extracting place names from unstructured text and resolving them to geographic coordinates using the [Irchel Geoparser](https://docs.geoparser.app/) library.

## Quick Start

### Prerequisites

- **Docker Desktop** ([download here](https://www.docker.com/products/docker-desktop))

### Getting Started

1. **Clone this repository:**

```bash
git clone https://github.com/dguzh/cas-geoparsing.git
cd cas-geoparsing
```

2. **Start the environment:**

```bash
docker compose up
```

> **Note:** First-time build takes 20-30 minutes (downloads ~14GB of gazetteer data). This only happens once!

3. **Open JupyterLab in your browser:**

```
http://localhost:8888
```

4. **Open and run the notebook** (`GeoparsingDemo.ipynb`)

That's it! All dependencies and gazetteers are pre-installed.

### Stopping

Press `Ctrl+C` or run:

```bash
docker compose down
```

## What's Included

- Python 3.13 with all required libraries
- Irchel Geoparser library (v0.3.0)
- GeoNames gazetteer (13GB, global coverage)
- SwissNames3D gazetteer (1.2GB, Swiss locations)
- spaCy models (`en_core_web_sm` and `en_core_web_trf`)
- JupyterLab environment

## Troubleshooting

**Port 8888 already in use?** Edit `docker-compose.yml` and change `"8888:8888"` to `"8889:8888"`, then access at `http://localhost:8889`

**Build interrupted?** Clean up and rebuild:
```bash
docker compose down --volumes
docker compose up --build
```

**Out of disk space?** Ensure at least 25GB of free space available.

---

For more details, see the [Irchel Geoparser documentation](https://docs.geoparser.app/).
