#!/bin/bash

uv run mkdocs build
git add .
git commit -m "publish"
git push
uv run mkdocs gh-deploy
