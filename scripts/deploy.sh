#!/usr/bin/env bash
set -Eeuo pipefail
: "${NEXUS_REGISTRY:?Set NEXUS_REGISTRY}"
: "${JFROG_REGISTRY:?Set JFROG_REGISTRY}"
: "${SONAR_HOST_URL:?Set SONAR_HOST_URL}"
: "${SONAR_TOKEN:?Set a project-scoped Sonar token}"
: "${SONAR_PROJECT_KEY:=devops-java-app}"
: "${IMAGE_NAME:=devops-java-app}"
: "${K8S_NAMESPACE:=default}"
: "${REGISTRY_SOURCE:=nexus}"
JAVA_DIR="${JAVA_DIR:-$(pwd)}"
IMAGE_TAG="${IMAGE_TAG:-$(git -C "$JAVA_DIR" rev-parse --short=12 HEAD)}"
for c in mvn docker kubectl; do command -v "$c" >/dev/null || { echo "$c is required" >&2; exit 127; }; done
mvn -B -f "$JAVA_DIR/pom.xml" clean verify
mvn -B -f "$JAVA_DIR/pom.xml" sonar:sonar -Dsonar.host.url="$SONAR_HOST_URL" -Dsonar.token="$SONAR_TOKEN" -Dsonar.projectKey="$SONAR_PROJECT_KEY"
docker build --pull -t "$IMAGE_NAME:$IMAGE_TAG" "$JAVA_DIR"
case "$REGISTRY_SOURCE" in
  nexus) : "${NEXUS_USER:?Set NEXUS_USER}"; : "${NEXUS_PASSWORD:?Set NEXUS_PASSWORD}"; REGISTRY="$NEXUS_REGISTRY"; USER="$NEXUS_USER"; PASS="$NEXUS_PASSWORD" ;;
  jfrog) : "${JFROG_USER:?Set JFROG_USER}"; : "${JFROG_PASSWORD:?Set JFROG_PASSWORD}"; REGISTRY="$JFROG_REGISTRY"; USER="$JFROG_USER"; PASS="$JFROG_PASSWORD" ;;
  *) echo "REGISTRY_SOURCE must be nexus or jfrog" >&2; exit 2 ;;
esac
printf '%s' "$PASS" | docker login "$REGISTRY" -u "$USER" --password-stdin
FULL_IMAGE="$REGISTRY/$IMAGE_NAME:$IMAGE_TAG"
docker tag "$IMAGE_NAME:$IMAGE_TAG" "$FULL_IMAGE"
docker push "$FULL_IMAGE"
docker logout "$REGISTRY"
kubectl -n "$K8S_NAMESPACE" set image "deployment/$IMAGE_NAME" "$IMAGE_NAME=$FULL_IMAGE"
kubectl -n "$K8S_NAMESPACE" rollout status "deployment/$IMAGE_NAME" --timeout=180s
