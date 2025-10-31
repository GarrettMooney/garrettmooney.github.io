# Quarto GitHub Blog Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Set up a Quarto-backed GitHub Pages blog with blog posts, notes section, and search functionality

**Architecture:** Quarto website with two main content sections (blog/notes), GitHub Actions for automated publishing to gh-pages branch, built-in search indexing all content

**Tech Stack:** Quarto, GitHub Actions, GitHub Pages

---

## Task 1: Create Quarto Configuration

**Files:**
- Create: `_quarto.yml`

**Step 1: Create main Quarto configuration file**

Create `_quarto.yml` with this content:

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
    toc-depth: 3
```

**Step 2: Verify configuration syntax**

Check that the YAML is valid. No command needed yet since Quarto isn't installed, but visually verify proper indentation and structure.

**Step 3: Commit**

```bash
git add _quarto.yml
git commit -m "feat: add Quarto site configuration

Configure website structure with blog and notes sections, search
functionality, and light/dark theme support."
```

---

## Task 2: Create Homepage

**Files:**
- Create: `index.qmd`

**Step 1: Create homepage content**

Create `index.qmd` with this content:

```markdown
---
title: "Garrett Mooney"
---

Welcome to my blog and notes. I write about software engineering, data science, and other technical topics.

## Recent Content

Browse my [blog posts](blog/index.qmd) for in-depth articles, or check out my [notes](notes/index.qmd) for quick references and guides.
```

**Step 2: Commit**

```bash
git add index.qmd
git commit -m "feat: add homepage with welcome message"
```

---

## Task 3: Set Up Blog Section Structure

**Files:**
- Create: `blog/index.qmd`
- Create: `blog/posts/_metadata.yml`

**Step 1: Create blog directory structure**

```bash
mkdir -p blog/posts
```

**Step 2: Create blog listing page**

Create `blog/index.qmd` with this content:

```markdown
---
title: "Blog"
listing:
  contents: posts
  sort: "date desc"
  type: default
  categories: true
  sort-ui: false
  filter-ui: false
  fields: [image, date, title, description, categories]
---

Technical articles and long-form content.
```

**Step 3: Create shared metadata for blog posts**

Create `blog/posts/_metadata.yml` with this content:

```yaml
author: "Garrett Mooney"
categories: []
```

**Step 4: Commit**

```bash
git add blog/
git commit -m "feat: set up blog section with listing page

Add blog listing page configured to display posts sorted by date,
with category filtering enabled."
```

---

## Task 4: Create Example Blog Post

**Files:**
- Create: `blog/posts/2025-10-30-welcome/index.qmd`

**Step 1: Create post directory**

```bash
mkdir -p blog/posts/2025-10-30-welcome
```

**Step 2: Create example blog post**

Create `blog/posts/2025-10-30-welcome/index.qmd` with this content:

```markdown
---
title: "Welcome to My Blog"
date: "2025-10-30"
description: "An introduction to this blog and what to expect"
categories: [meta]
---

Welcome! This is the first post on my new Quarto-powered blog.

## What is Quarto?

[Quarto](https://quarto.org/) is an open-source scientific and technical publishing system. It's great for:

- Writing technical content with code
- Creating beautiful, responsive websites
- Supporting multiple programming languages
- Built-in search and navigation

## What to Expect

I'll be writing about:

- Software engineering practices
- Data science and analysis
- Tools and workflows
- Whatever else I find interesting

Stay tuned for more content!

## Code Example

Here's a simple Python example:

```python
def greet(name: str) -> str:
    return f"Hello, {name}!"

print(greet("World"))
```

This blog supports syntax highlighting for many languages out of the box.
```

**Step 3: Commit**

```bash
git add blog/posts/2025-10-30-welcome/
git commit -m "feat: add welcome blog post

Create example blog post demonstrating Quarto features including
code blocks with syntax highlighting."
```

---

## Task 5: Set Up Notes Section Structure

**Files:**
- Create: `notes/index.qmd`
- Create: `notes/_metadata.yml`

**Step 1: Create notes directory**

```bash
mkdir -p notes
```

**Step 2: Create notes listing page**

Create `notes/index.qmd` with this content:

```markdown
---
title: "Notes"
listing:
  contents: "*.qmd"
  sort: "title"
  type: table
  fields: [title, description]
  sort-ui: false
  filter-ui: false
---

Quick references, guides, and technical notes.
```

**Step 3: Create shared metadata for notes**

Create `notes/_metadata.yml` with this content:

```yaml
author: "Garrett Mooney"
```

**Step 4: Commit**

```bash
git add notes/
git commit -m "feat: set up notes section with listing page

Add notes listing page configured to display notes in table format,
sorted alphabetically by title."
```

---

## Task 6: Create Example Note

**Files:**
- Create: `notes/git-worktrees.qmd`

**Step 1: Create example note**

Create `notes/git-worktrees.qmd` with this content:

```markdown
---
title: "Git Worktrees"
description: "Quick reference for working with git worktrees"
---

Git worktrees allow you to check out multiple branches simultaneously in different directories.

## Creating a Worktree

```bash
# Create new worktree with new branch
git worktree add path/to/worktree -b branch-name

# Create worktree from existing branch
git worktree add path/to/worktree existing-branch
```

## Listing Worktrees

```bash
git worktree list
```

## Removing a Worktree

```bash
# Remove worktree directory first
rm -rf path/to/worktree

# Then prune the worktree reference
git worktree prune
```

## Use Cases

- Work on multiple features simultaneously
- Keep a clean main branch checked out for quick reference
- Test changes across different branches without stashing
```

**Step 2: Commit**

```bash
git add notes/git-worktrees.qmd
git commit -m "feat: add git worktrees reference note

Create example note demonstrating reference-style content format."
```

---

## Task 7: Add Custom Styles

**Files:**
- Create: `styles.css`

**Step 1: Create minimal custom stylesheet**

Create `styles.css` with this content:

```css
/* Custom styles for Garrett Mooney's blog */

/* Improve code block readability */
pre {
  border-radius: 4px;
  padding: 1em;
}

/* Adjust navbar spacing */
.navbar {
  padding-top: 0.5rem;
  padding-bottom: 0.5rem;
}

/* Make the title link more prominent */
.navbar-title {
  font-weight: 600;
}

/* Add some breathing room to main content */
.quarto-title-block {
  margin-bottom: 2rem;
}

/* Style the listing cards nicely */
.quarto-listing-default .listing-item {
  margin-bottom: 1.5rem;
}
```

**Step 2: Commit**

```bash
git add styles.css
git commit -m "feat: add custom CSS styles

Add minimal custom styling for improved readability and spacing."
```

---

## Task 8: Set Up GitHub Actions Workflow

**Files:**
- Create: `.github/workflows/publish.yml`

**Step 1: Create workflows directory**

```bash
mkdir -p .github/workflows
```

**Step 2: Create GitHub Actions workflow**

Create `.github/workflows/publish.yml` with this content:

```yaml
name: Publish Quarto Site

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Quarto
        uses: quarto-dev/quarto-actions/setup@v2
        with:
          version: 1.4.549

      - name: Render Quarto Project
        uses: quarto-dev/quarto-actions/render@v2

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: _site

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

**Step 3: Commit**

```bash
git add .github/workflows/publish.yml
git commit -m "feat: add GitHub Actions workflow for publishing

Set up automated Quarto rendering and deployment to GitHub Pages
on push to main branch."
```

---

## Task 9: Local Testing Setup (Optional)

**Note:** This task is optional but recommended for testing before pushing. Skip if Quarto is not installed locally.

**Prerequisites:**
- Quarto must be installed (https://quarto.org/docs/get-started/)
- Run: `quarto check` to verify installation

**Step 1: Render the site locally**

```bash
quarto render
```

Expected output: Site rendered to `_site/` directory with no errors

**Step 2: Preview the site**

```bash
quarto preview
```

Expected: Opens browser to http://localhost:4200 showing the site

**Step 3: Verify key features**

Manual verification checklist:
- [ ] Homepage loads and shows welcome message
- [ ] Blog listing page shows welcome post
- [ ] Welcome post renders correctly with syntax highlighting
- [ ] Notes listing page shows git worktrees note
- [ ] Git worktrees note displays correctly
- [ ] Search box appears in navbar (top right)
- [ ] Search indexes content (try searching "quarto" or "git")
- [ ] Dark mode toggle works (usually in top right)
- [ ] Navigation links work (Blog, Notes, GitHub)

**Step 4: Stop preview server**

Press `Ctrl+C` in terminal running `quarto preview`

---

## Task 10: Final Commit and Push

**Step 1: Verify all files are committed**

```bash
git status
```

Expected output: "nothing to commit, working tree clean"

If there are untracked files, review and commit them.

**Step 2: Push to remote**

```bash
git push -u origin feature/quarto-blog-setup
```

Expected: Branch pushed successfully to GitHub

**Step 3: Verify GitHub Actions workflow file is present**

```bash
ls -la .github/workflows/publish.yml
```

Expected: File exists

---

## Post-Implementation: Merge and Deploy

**After all tasks complete, merge to main:**

```bash
# Switch to main branch (in main worktree, not this one)
cd ../../  # Back to main worktree
git checkout main

# Merge the feature branch
git merge feature/quarto-blog-setup

# Push to trigger GitHub Actions
git push origin main
```

**Configure GitHub Pages:**

1. Go to repository Settings → Pages
2. Ensure "Source" is set to "GitHub Actions"
3. Wait for workflow to complete (check Actions tab)
4. Site will be available at https://garrettmooney.github.io

**Verify deployment:**
- Check GitHub Actions tab for successful workflow run
- Visit https://garrettmooney.github.io
- Verify all content displays correctly
- Test search functionality
- Test dark mode toggle

---

## Success Criteria

- [ ] All files created with correct content
- [ ] Quarto site renders without errors
- [ ] Blog and notes sections display correctly
- [ ] Search functionality works
- [ ] GitHub Actions workflow configured
- [ ] Site publishes successfully to GitHub Pages
- [ ] All navigation links work
- [ ] Dark/light mode toggle works

---

## Troubleshooting

**Issue: Quarto render fails with "command not found"**
- Solution: Install Quarto from https://quarto.org/docs/get-started/

**Issue: GitHub Actions fails on first run**
- Solution: Check Settings → Pages → Source is set to "GitHub Actions"

**Issue: Site shows 404 after deployment**
- Solution: Wait 1-2 minutes for GitHub Pages to update after first deploy

**Issue: Search box doesn't appear**
- Solution: Verify `website.search: true` is set in `_quarto.yml`

**Issue: Dark mode toggle missing**
- Solution: Verify both `light` and `dark` themes are specified in `_quarto.yml`
