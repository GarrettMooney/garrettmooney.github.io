# Quarto GitHub Blog Design

**Date:** 2025-10-30
**Repository:** garrettmooney.github.io
**Purpose:** Create a Quarto-backed GitHub Pages blog with blog posts, notes section, and search functionality

## Overview

This design establishes a Quarto website published to GitHub Pages (garrettmooney.github.io) with two main content sections: chronological blog posts and reference-style notes. The site will use Quarto's built-in search functionality and GitHub Actions for automated publishing.

## Project Structure

```
garrettmooney.github.io/
├── _quarto.yml              # Main Quarto configuration
├── index.qmd                # Homepage
├── blog/
│   ├── index.qmd            # Blog listing page
│   ├── posts/
│   │   ├── _metadata.yml    # Shared metadata for all posts
│   │   └── 2025-01-15-example-post/
│   │       └── index.qmd    # Individual post
├── notes/
│   ├── index.qmd            # Notes listing page
│   ├── _metadata.yml        # Shared metadata for notes
│   └── *.qmd                # Individual note files
├── styles.css               # Custom CSS (optional)
└── .github/
    └── workflows/
        └── publish.yml      # GitHub Actions workflow
```

### Directory Organization

**Blog Posts:**
- Located in `blog/posts/`
- Each post in date-prefixed folder: `YYYY-MM-DD-post-title/index.qmd`
- Supports co-location of images and resources with post
- Shared metadata via `blog/posts/_metadata.yml`

**Notes:**
- Located in `notes/`
- Flat structure with individual `.qmd` files
- Reference-style content (less chronological than blog)
- Shared metadata via `notes/_metadata.yml`

## Quarto Configuration

### Core Settings (`_quarto.yml`)

```yaml
project:
  type: website
  output-dir: _site

website:
  title: "Garrett Mooney"
  navbar:
    left:
      - text: "Blog"
        href: blog/index.qmd
      - text: "Notes"
        href: notes/index.qmd
    right:
      - icon: github
        href: https://github.com/garrettmooney
  search: true

format:
  html:
    theme:
      light: cosmo
      dark: darkly
    css: styles.css
    toc: true
```

### Search Functionality

Quarto provides built-in client-side search:
- Automatically indexes all `.qmd` content (titles, headings, body text)
- Search box appears in navbar when `website.search: true`
- No external dependencies or setup required
- Works offline after initial page load

### Listing Pages

**Blog Listing (`blog/index.qmd`):**
```yaml
---
title: "Blog"
listing:
  contents: posts
  sort: "date desc"
  type: default
  categories: true
  sort-ui: false
  filter-ui: false
---
```

**Notes Listing (`notes/index.qmd`):**
```yaml
---
title: "Notes"
listing:
  contents: "*.qmd"
  sort: "title"
  type: table
  fields: [title, description]
---
```

## Publishing Workflow

### GitHub Actions

The site publishes via GitHub Action to `gh-pages` branch:

**Workflow file (`.github/workflows/publish.yml`):**
- Triggers on push to `main` branch
- Uses Quarto's official `quarto-dev/quarto-actions/publish@v2` action
- Renders site and pushes output to `gh-pages` branch
- GitHub Pages serves from `gh-pages` branch

**Publishing Flow:**
1. Developer pushes `.qmd` changes to `main`
2. GitHub Action triggers automatically
3. Quarto renders all content to HTML
4. Action commits output to `gh-pages` branch
5. GitHub Pages updates site (typically within 1-2 minutes)

### Branch Structure

- `main`: Source files (`.qmd`, `_quarto.yml`, assets)
- `gh-pages`: Generated HTML (created/managed by Action)

`.gitignore` excludes build artifacts (`/.quarto/`, `_site/`) from source branch.

## Theme and Styling

### Base Theme

- **Light mode:** Cosmo (clean, modern, professional)
- **Dark mode:** Darkly (good contrast, easy reading)
- Built-in dark mode toggle provided by Quarto

### Custom Styling

Optional `styles.css` for minor tweaks:
- Typography adjustments
- Custom link colors
- Spacing/padding refinements

No custom SCSS compilation needed - keep it simple.

## Initial Content

### Homepage (`index.qmd`)

Brief introduction with links to Blog and Notes sections.

### Example Blog Post

`blog/posts/2025-10-30-example-post/index.qmd` demonstrates:
- YAML frontmatter (title, date, description, categories)
- Markdown content
- Code blocks with syntax highlighting
- Image embedding

### Example Note

`notes/example-note.qmd` demonstrates simpler note format:
- Title and description
- Reference-style content
- No date field required

## Metadata Management

### Shared Post Metadata (`blog/posts/_metadata.yml`)

```yaml
author: "Garrett Mooney"
categories: []
```

Applied to all posts automatically, can be overridden per-post.

### Shared Notes Metadata (`notes/_metadata.yml`)

```yaml
author: "Garrett Mooney"
```

## Success Criteria

1. Site publishes successfully to garrettmooney.github.io
2. Blog and notes sections display with proper listings
3. Search indexes all content and returns relevant results
4. GitHub Action builds and deploys on push to main
5. Dark mode toggle works correctly
6. Example content demonstrates the structure for future additions

## Future Enhancements (Out of Scope)

- RSS feed generation
- Comments system (utterances, giscus)
- Analytics integration
- Custom domain
- Tags/categories filtering UI
- Social media cards/SEO optimization

These can be added incrementally after the core blog is functional.
