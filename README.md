# feature-toggle-importer

Docker image to setup feature toggles used via FF4J feature-toggle-api (https://github.com/hmcts/feature-toggle-api). 

2 scripts available to use as you see fit:
```
/scripts/add-weighted-toggle.sh TOGGLE_NAME TOGGLE_DESCRIPTION TOGGLE_WEIGHT ADMIN_USER ADMIN_PASSWORD
/scripts/add-toggle.sh TOGGLE_NAME TOGGLE_DESCRIPTION TOGGLE_ENABLED ADMIN_USER ADMIN_PASSWORD
```

Note: for `add-weighted-toggle` you can set permissions with environment variable: `PERMISSIONS`

## Example

docker-compose.yaml snippet:
```
    feature-toggle-importer:
      image: hmcts/feature-toggle-importer
      command: >
        sh -c "/scripts/add-weighted-toggle.sh cmc_admissions 'CMC admissions' '1.0' admin@example.com Password12 &&
               /scripts/add-toggle.sh cmc_defence_reminders 'CMC defence reminders' false admin@example.com Password12"
      environment:
        PERMISSIONS: cmc-new-features-consent-given
        FEATURE_TOGGLE_API_URL: http://feature-toggle-api:8580/api/ff4j/store/features/
```
