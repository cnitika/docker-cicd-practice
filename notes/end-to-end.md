# End-to-end flow

git push (main)
  -> GitHub Actions: install, build, test + coverage (build-test)
  -> docker-image job: build image, push to GHCR (:latest and :<sha>)
  -> deploy: docker compose pull && up -d (app runs the new image)
  -> app talks to host PostgreSQL (primary 5432; replica 5433 used for the failover test)
Parallel: Jenkins runs the same build/test from the Jenkinsfile and archives coverage artifacts.

## Proof
- Actions run #15: build-test and docker-image both green (38s total).
- Visible change: app output changed from "Visits: 16" to "Visits (v2): 18" after deploying the CI-built image.
- App connected to external host PostgreSQL throughout.
