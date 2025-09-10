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
    #!/bin/bash
    set -euxo pipefail

    VENV_PATH=".venv-{{name}}"
    KERNEL_NAME="garrett-{{name}}"

    echo "Removing venv at $VENV_PATH..."
    rm -rf "$VENV_PATH"

    echo "Removing Jupyter kernel '$KERNEL_NAME'..."
    # The '|| true' is to prevent an error if the kernel doesn't exist
    uvx jupyter kernelspec uninstall -y "$KERNEL_NAME" || true

    echo -e "\nSuccessfully removed venv and kernel for '{{name}}'"
