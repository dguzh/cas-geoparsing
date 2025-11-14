# Geoparsing Demo - Docker Environment

This repository provides a ready-to-use Docker environment for learning about **geoparsing** - the process of automatically extracting place names from text and resolving them to geographic coordinates. The environment includes Jupyter notebooks that demonstrate these techniques using the [Irchel Geoparser](https://docs.geoparser.app/) library.

## Quick Start

### Prerequisites

Install **Docker Desktop** on your computer:

```
https://www.docker.com/products/docker-desktop
```

> **Important:** Ensure you have at least **30GB of free disk space** for the Docker image and gazetteer data.

### Step 1: Download the Environment

Run this command to download the pre-built environment:

```bash
docker compose -f https://raw.githubusercontent.com/dguzh/cas-geoparsing/main/docker-compose.cloud.yml pull
```

> **Note:** This downloads the pre-built image (~15GB). Takes 10-20 minutes depending on your internet connection.

You'll see a "Downloaded" message when complete.

### Step 2: Start JupyterLab

```bash
docker compose -f https://raw.githubusercontent.com/dguzh/cas-geoparsing/main/docker-compose.cloud.yml up
```

Then open JupyterLab in your browser:

```
http://localhost:8888
```

## Notebooks Included

1. **GeoparsingDemo.ipynb** - Learn how to extract locations from documents and evaluate geoparsing accuracy
2. **MappingTextsDemo.ipynb** - Visualize geographic references in literature with interactive maps

## Stopping the Environment

Press `Ctrl+C` in the terminal, or run:

```bash
docker compose -f https://raw.githubusercontent.com/dguzh/cas-geoparsing/main/docker-compose.cloud.yml down
```

## What's Pre-installed

- Python 3.13 with scientific computing libraries (pandas, numpy, matplotlib, seaborn, plotly)
- Irchel Geoparser library (v0.3.0)
- GeoNames gazetteer (13GB, global coverage with 13+ million place names)
- spaCy NLP model (`en_core_web_sm`)
- JupyterLab environment

Your notebook changes are automatically saved to your local filesystem.

---

For questions about the Irchel Geoparser library, see the [documentation](https://docs.geoparser.app/).
