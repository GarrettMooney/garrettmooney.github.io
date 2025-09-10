# Virtual Environment Setup for Quarto Blog Posts

This document explains how to use different Python virtual environments for different blog posts in your Quarto site.

## Overview

We've set up a system where:
- The project has a default Python environment (`.venv`) with basic dependencies
- You can create post-specific environments with specialized dependencies
- Each environment is registered as a Jupyter kernel that Quarto can use

## Current Setup

### 1. Project-Level Environment (`.venv`)
- **Location**: `.venv/`
- **Kernel Name**: `garrett-site`
- **Display Name**: "Garrett Site"
- **Dependencies**: PyYAML, jupyter, ipykernel (basic dependencies needed for Quarto)
- **Usage**: Default environment specified in `_quarto.yml`

### 2. Bayesian Analysis Environment (`.venv-bayesian`)
- **Location**: `.venv-bayesian/`
- **Kernel Name**: `garrett-bayesian`
- **Display Name**: "Bayesian (NumPyro)"
- **Dependencies**: NumPyro, JAX, matplotlib, seaborn, pandas, plus Jupyter dependencies
- **Usage**: Specified in blog post YAML frontmatter

## How to Use Different Environments for Blog Posts

### Option 1: Use the Default Environment
If your blog post doesn't specify a `jupyter` field in the YAML frontmatter, it will use the default project environment specified in `_quarto.yml`.

```yaml
---
title: "My Blog Post"
author: "Garrett Mooney"
date: "2025-01-09"
# No jupyter field = uses default environment
---
```

### Option 2: Specify a Custom Kernel
To use a specific virtual environment for a blog post, add the `jupyter` field to the YAML frontmatter:

```yaml
---
title: "Bayesian Analysis Example"
author: "Garrett Mooney"
date: "2025-01-09"
jupyter: garrett-bayesian  # Uses the Bayesian environment
---
```

## Creating New Environments for Specific Use Cases

### Step 1: Create the Virtual Environment
```bash
python3 -m venv .venv-{name}
```

### Step 2: Install Dependencies
```bash
source .venv-{name}/bin/activate
pip install ipykernel jupyter PyYAML  # Always include these
pip install {your-specific-packages}  # Add your specialized packages
```

### Step 3: Create Jupyter Kernel
```bash
source .venv-{name}/bin/activate
python -m ipykernel install --user --name garrett-{name} --display-name "{Display Name}"
```

### Step 4: Use in Blog Posts
Add `jupyter: garrett-{name}` to your blog post's YAML frontmatter.

## Example Use Cases

### Data Analysis Environment
```bash
python3 -m venv .venv-data
source .venv-data/bin/activate
pip install ipykernel jupyter PyYAML pandas polars duckdb matplotlib seaborn plotly
python -m ipykernel install --user --name garrett-data --display-name "Data Analysis"
```

### Machine Learning Environment
```bash
python3 -m venv .venv-ml
source .venv-ml/bin/activate
pip install ipykernel jupyter PyYAML scikit-learn tensorflow torch transformers datasets
python -m ipykernel install --user --name garrett-ml --display-name "Machine Learning"
```

### Web Scraping Environment
```bash
python3 -m venv .venv-scraping
source .venv-scraping/bin/activate
pip install ipykernel jupyter PyYAML requests beautifulsoup4 selenium scrapy
python -m ipykernel install --user --name garrett-scraping --display-name "Web Scraping"
```

## Configuration Files

### `_quarto.yml` Configuration
The project-level configuration specifies the default Python environment:

```yaml
project:
  type: website

jupyter: python3
python:
  path: ../.venv/bin/python
```

## Troubleshooting

### Common Issues
1. **"Module not found" errors**: Make sure the required packages are installed in the specific environment
2. **Kernel not found**: Ensure you've run `python -m ipykernel install --user --name {kernel-name}`
3. **PyYAML missing**: Always install `PyYAML jupyter ipykernel` in every environment

### Listing Available Kernels
```bash
jupyter kernelspec list
```

### Removing a Kernel
```bash
jupyter kernelspec remove {kernel-name}
```

## Best Practices

1. **Always include base dependencies**: Every environment should have `ipykernel`, `jupyter`, and `PyYAML`
2. **Use descriptive kernel names**: Follow the pattern `garrett-{purpose}` for consistency
3. **Document dependencies**: Keep track of what packages are in each environment
4. **Pin versions**: Consider using `requirements.txt` files for reproducible environments
5. **Test before publishing**: Always test your blog posts with `just preview` before committing
