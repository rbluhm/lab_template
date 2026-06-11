#!/bin/bash

echo "Creating directories..."
echo "Manually create ./../data/input"
echo ".. and also create ./../data/input/restricted and rest is considered public in input"

mkdir data
mkdir data/intermediate
mkdir data/intermediate/restricted
mkdir data/final
mkdir data/final/restricted
mkdir output
mkdir output/figures
mkdir output/tables
mkdir output/figures/appendix
mkdir output/tables/appendix
mkdir tmp
mkdir tmp/restricted
mkdir sandbox      # git-ignored agent scratch space
