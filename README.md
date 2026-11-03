# Geoparsing Demo - Docker Environment

This repository provides a ready-to-use Docker environment for learning about **geoparsing** — the process of automatically extracting place names from text and resolving them to geographic coordinates. The environment includes Jupyter notebooks that demonstrate these techniques using the [Irchel Geoparser](https://docs.geoparser.app/) library.

## Quick Start

### Prerequisites

Install [Docker Desktop](https://www.docker.com/products/docker-desktop) on your computer.

> **Important:** Ensure you have at least **30 GB of free disk space**. The image includes the GeoNames gazetteer (about 10 GB) together with the Python libraries, and it expands to roughly 30 GB.

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

> **Note:** This downloads the pre-built image (compressed to about 10 GB). It takes several minutes, depending on your internet connection.

### Step 3: Start JupyterLab

```bash
docker compose -f docker-compose.cloud.yml up
```

Then open JupyterLab in your browser: [localhost:8888](http://localhost:8888)

## Notebooks Included

1. **GeoparsingDemo.ipynb** — Extract locations from documents and evaluate geoparsing accuracy
2. **MappingTextsDemo.ipynb** — Visualize geographic references in literature with interactive maps

## Stopping the Environment

In the terminal where JupyterLab is running, press `Ctrl+C` **twice**:

- First time: Stops Jupyter Server
- Second time: Stops Docker container

## What's Pre-installed

- Python 3.13 with computing and plotting libraries (pandas, numpy, matplotlib, plotly)
- Irchel Geoparser library (v0.6.2)
- GeoNames gazetteer (about 10 GB, global coverage, 13 million features)
- spaCy models (`en_core_web_sm`, `en_core_web_trf`, `xx_sent_ud_sm`)
- The resolver model `dguzh/geo-all-MiniLM-L6-v2`
- JupyterLab environment

## Building the Image Yourself

`docker-compose.yml` builds the image from this repository instead of pulling it. The GeoNames install needs about **31 GB free** while it compiles, and takes about 10–20 minutes. The finished gazetteer file is about 10 GB; the extra space is released when the build finishes.

```bash
docker compose up --build
```

---

For questions about the Irchel Geoparser library, see the [documentation](https://docs.geoparser.app/).
