#!/bin/bash
set -e

az account set --subscription DCD-CNP-DEV
az acr task show --registry hmctspublic --name task-feature-toggle-importer 