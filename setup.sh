#!/bin/bash

echo "Creating directories..."
echo "Manually create ./../data/input"
echo ".. and also create ./../data/input/restricted and rest is considered public in input"

# -p so re-running is harmless: most of these folders ship tracked (via .gitkeep)
mkdir -p data/intermediate/restricted
mkdir -p data/final/restricted
mkdir -p output/figures/appendix
mkdir -p output/tables/appendix
mkdir -p tmp/restricted
mkdir -p sandbox      # git-ignored agent scratch space

# Make sure CLAUDE.md points at AGENTS.md (single source of agent rules)
ln -sf AGENTS.md CLAUDE.md
