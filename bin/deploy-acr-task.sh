#!/bin/bash
set -e

az account set --subscription DCD-CNP-DEV
az acr task create \
    --registry hmctspublic \
    --name task-feature-toggle-importer \
    --file acr-build-task.yaml \
    --context https://github.com/hmcts/feature-toggle-importer.git \
    --branch master \
    --git-access-token $GITHUB_TOKEN