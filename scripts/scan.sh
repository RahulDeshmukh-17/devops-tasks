#!/usr/bin/env bash
set -Eeuo pipefail
: "${SONAR_HOST_URL:?Set SONAR_HOST_URL}"
: "${SONAR_PROJECT_KEY:?Set SONAR_PROJECT_KEY}"
: "${SONAR_TOKEN:?Inject a project-scoped token with <=24h lifetime}"
: "${SONAR_SCANNER_CMD:=sonar-scanner}"
# Create the token in SonarQube with only the target project's analysis permission
# and an expiration of 1 day. Inject it via a CI secret/secret manager, never commit it.
# Token creation APIs and permission names vary by SonarQube version/edition; configure
# token creation separately and verify the resulting token's project scope and expiry.
"$SONAR_SCANNER_CMD" -Dsonar.host.url="$SONAR_HOST_URL" -Dsonar.projectKey="$SONAR_PROJECT_KEY" -Dsonar.token="$SONAR_TOKEN"
unset SONAR_TOKEN
