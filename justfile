# view all available commands
@_:
    just --list

# compile and preview the blog
preview:
    quarto preview garrett-site

# create a new virtual environment and jupyter kernel
# example: just new-env data-analysis "Data Analysis" "pandas polars"
new-env name display_name packages='':
    #!/bin/bash
    set -euxo pipefail

    VENV_PATH=".venv-{{name}}"
    KERNEL_NAME="garrett-{{name}}"

    echo "Creating venv at $VENV_PATH..."
    uv venv "$VENV_PATH"

    source "$VENV_PATH/bin/activate"

    echo "Installing base dependencies..."
    uv pip install ipykernel jupyter PyYAML

    if [ -n "{{packages}}" ]; then
        echo "Installing extra packages: {{packages}}"
        uv pip install {{packages}}
    fi

    echo "Creating Jupyter kernel '$KERNEL_NAME'..."
    uv run python -m ipykernel install --user --name "$KERNEL_NAME" --display-name "{{display_name}}"

    echo -e "\nSuccessfully created venv '$VENV_PATH' and kernel '$KERNEL_NAME'"
    echo "To use it in a post, add the following to the frontmatter:"
    echo "jupyter: $KERNEL_NAME"

# remove a virtual environment and jupyter kernel
# example: just rm-env data-analysis
rm-env name:
    #!/usr/bin/env bash
    VENV_PATH=".venv-{{name}}"
    KERNEL_NAME="garrett-{{name}}"

    # Check if venv directory exists
    if [ -d "$VENV_PATH" ]; then
        echo "Removing venv at $VENV_PATH..."
        rm -rf "$VENV_PATH"
    else
        echo "Venv '$VENV_PATH' not found, skipping removal."
    fi

    # Check if kernel exists
    if uvx --from jupyter-client jupyter-kernelspec list | grep -q "$KERNEL_NAME"; then
        echo "Removing Jupyter kernel '$KERNEL_NAME'..."
        uvx --from jupyter-client jupyter-kernelspec uninstall -y "$KERNEL_NAME"
    else
        echo "Jupyter kernel '$KERNEL_NAME' not found, skipping removal."
    fi