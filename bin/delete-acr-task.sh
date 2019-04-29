#!/bin/bash
set -e

az account set --subscription DCD-CNP-DEV
az acr task delete -r hmctspublic -n task-feature-toggle-importer