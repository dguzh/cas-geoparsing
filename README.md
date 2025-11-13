# Geoparsing Demo - Docker Environment

This repository provides a ready-to-use Docker environment for learning about **geoparsing** - the process of automatically extracting place names from text and resolving them to geographic coordinates. The environment includes a Jupyter notebook that demonstrates these techniques using the [Irchel Geoparser](https://docs.geoparser.app/) library.

## Quick Start

### Prerequisites

Install **Docker Desktop** on your computer:

```
https://www.docker.com/products/docker-desktop
```

> **Important:** Ensure you have at least **25GB of free disk space** for the Docker image and gazetteer data.

### Getting Started

**Step 1:** Clone this repository

```bash
git clone https://github.com/dguzh/cas-geoparsing.git
```

**Step 2:** Navigate to the directory

```bash
cd cas-geoparsing
```

**Step 3:** Start the Docker environment

```bash
docker compose up
```

> **Note:** The first build takes 20-30 minutes as it downloads ~14GB of gazetteer data. This only happens once!

**Step 4:** Open JupyterLab in your browser

```
http://localhost:8888
```

**Step 5:** Open and run the notebook `GeoparsingDemo.ipynb`

### Stopping the Environment

Press `Ctrl+C` in the terminal, or run:

```bash
docker compose down
```

## What's Pre-installed

- Python 3.13 with scientific computing libraries (pandas, numpy, matplotlib, seaborn)
- Irchel Geoparser library (v0.3.0)
- GeoNames gazetteer (13GB, global coverage with 13+ million place names)
- SwissNames3D gazetteer (1.2GB, high-quality Swiss locations)
- spaCy NLP models (`en_core_web_sm` and `en_core_web_trf`)
- JupyterLab environment

Your notebook changes are automatically saved to your local filesystem.

---

For questions about the Irchel Geoparser library, see the [documentation](https://docs.geoparser.app/).
