# Geoparsing Demo - Docker Environment

This repository provides a ready-to-use Docker environment for learning about **geoparsing** - the process of automatically extracting place names from text and resolving them to geographic coordinates. The environment includes Jupyter notebooks that demonstrate these techniques using the [Irchel Geoparser](https://docs.geoparser.app/) library.

## Quick Start

### Prerequisites

Install [Docker Desktop](https://www.docker.com/products/docker-desktop) on your computer.

> **Important:** Ensure you have at least **35GB of free disk space** for Docker Desktop, the Docker image and the GeoNames data.

### Step 1: Download the Configuration File

**On Windows (PowerShell):**

```powershell
curl.exe -O https://raw.githubusercontent.com/dguzh/cas-geoparsing/main/docker-compose.cloud.yml
```

**On macOS/Linux:**

```bash
curl -O https://raw.githubusercontent.com/dguzh/cas-geoparsing/main/docker-compose.cloud.yml
```

### Step 2: Download the Environment

```bash
docker compose -f docker-compose.cloud.yml pull
```

> **Note:** This downloads the pre-built image (~10GB). Takes 10-20 minutes depending on your internet connection.

You'll see a "Downloaded" message when complete.

### Step 3: Start JupyterLab

```bash
docker compose -f docker-compose.cloud.yml up
```

Then open JupyterLab in your browser: [localhost:8888](http://localhost:8888)

## Notebooks Included

1. **GeoparsingDemo.ipynb** - Learn how to extract locations from documents and evaluate geoparsing accuracy
2. **MappingTextsDemo.ipynb** - Visualize geographic references in literature with interactive maps

## Stopping the Environment

In the terminal where JupyterLab is running, press `Ctrl+C` **twice**:
- First time: Stops Jupyter Server
- Second time: Stops Docker container

## What's Pre-installed

- Python 3.13 with scientific computing libraries (pandas, numpy, matplotlib, plotly)
- Irchel Geoparser library (v0.3.0)
- GeoNames gazetteer (13GB, global coverage with 13+ million place names)
- spaCy NLP models (`en_core_web_sm`, `xx_sent_ud_sm`)
- JupyterLab environment

Your notebook changes are automatically saved to your local filesystem.

---

For questions about the Irchel Geoparser library, see the [documentation](https://docs.geoparser.app/).
