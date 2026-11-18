# GitHub Actions vs Jenkins

| | GitHub Actions | Jenkins |
|---|---|---|
| Setup | No server; workflow file in repo (.github/workflows/ci.yml) | Self-hosted server (I ran it in Docker) |
| Config | YAML workflow | Jenkinsfile (Groovy) |
| Hosting | GitHub-managed runners | Self-hosted, I maintain it |
| Triggers | push, PR, schedule built in | Webhook or polling needs setup |
| Plugins | Marketplace actions | Large plugin ecosystem, updates/compat are my job |
| Cost | Free for public repos, limits on private | Software free, server cost |
| Control | Less (runner limits) | More (own environment, tools, network) |
| Artifacts | actions/upload-artifact | archiveArtifacts |
| Best for | Small/medium GitHub-based projects | Custom/on-prem setups needing control |

## My experience
GitHub Actions took minutes to set up. Jenkins took longer: I had to build an image with Node installed and fix a port 8080 conflict (moved to 8081).
