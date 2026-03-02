#!/bin/bash

mkdocs build
git add .
git commit -m "publish"
git push
mkdocs gh-deploy
