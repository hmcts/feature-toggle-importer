# feature-toggle-importer

Docker image to setup feature toggles used via FF4J feature-toggle-api (https://github.com/hmcts/feature-toggle-api). 

## Building

Dockerhub (https://cloud.docker.com/u/hmcts/repository/docker/hmcts/feature-toggle-importer) is deprecated - please use ACR.

Any commit or merge into master will automatically trigger an Azure ACR task. This task has been manually
created using `./bin/deploy-acr-task.sh`. The task is defined in `acr-build-task.yaml`. 

Note: you will need a GitHub personal token defined in `GITHUB_TOKEN` environment variable to run deploy script (https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line). The token is for setting up a webhook so Azure will be notified when a merge or commit happens. Make sure you are a repo admin and select token scope of: `admin:repo_hook  Full control of repository hooks`

More info on ACR tasks can be read here: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tasks-overview

2 scripts available to use as you see fit:
```
/scripts/add-weighted-toggle.sh TOGGLE_NAME TOGGLE_DESCRIPTION TOGGLE_WEIGHT
/scripts/add-toggle.sh TOGGLE_NAME TOGGLE_DESCRIPTION TOGGLE_ENABLED
```

Note: for `add-weighted-toggle` you can set permissions with environment variable: `PERMISSIONS`

## Example

docker-compose.yaml snippet:
```
    feature-toggle-importer:
      image: hmctspublic.azurecr.io/hmcts/feature-toggle-importer
      command: >
        sh -c "/scripts/add-weighted-toggle.sh cmc_admissions 'CMC admissions' '1.0' &&
               /scripts/add-toggle.sh cmc_defence_reminders 'CMC defence reminders' false"
      environment:
        PERMISSIONS: cmc-new-features-consent-given
        FEATURE_TOGGLE_API_URL: http://feature-toggle-api:8580/api/ff4j/store/features/
        ADMIN_USERNAME: admin@example.com
        ADMIN_PASSWORD: Password12
```
