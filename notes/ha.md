# High availability: write-up for my setup

## What I built

* App + PostgreSQL (Docker Compose), later moved to PostgreSQL on the host.
* Primary (port 5432) + streaming replica (port 5433), failover tested by promoting the replica.
* Backups with pg\_dump (timestamped, last 7 kept), restore tested. transfer.sh to copy backups to another host.
* File sync with rsync + cron (tested between two folders).
* CI on GitHub Actions and Jenkins. Static site on Cloudflare.

## Concepts applied to this setup

### Backups

* Have: scheduled-style pg\_dump with rotation and a tested restore.
* Gap: backups sit on the same machine as the database, so a disk or machine loss loses both. Fix: run transfer.sh against a real remote host or object storage, and run backup.sh on a schedule.

### Load balancing

* Have: none. One app container serves all traffic.
* Next step: run 2+ app containers behind nginx (or Cloudflare Load Balancing) with health checks. The app is stateless, so this is easy; state lives in PostgreSQL.

### Scaling

* Now: vertical only (bigger machine).
* Horizontal: more app containers for traffic; read replicas for read-heavy load. The replica I built can serve reads, but writes still go to a single primary.

### Disaster recovery (the zone gap)

* Primary and replica are on the same machine. This protects against a Postgres crash or corruption on one instance, but not against the machine, power, or the whole zone/site failing.
* Fix: place the replica on a different machine in a different zone/region, and keep off-site backups.
* Failover observed: I promoted the replica manually (pg\_ctl promote). It worked, but it needs a person, so there is downtime. RTO: \[2 minutes]. RPO: replication is asynchronous, so the last few commits before a crash could be lost.
* Production: use Patroni or repmgr for automatic failover, with a witness/quorum to avoid split brain. The old primary must be rebuilt (pg\_rewind or fresh basebackup) before rejoining.

### Reduced dependency (DNS / CDN / server)

* Single points of failure today: one machine, one DNS provider, one CDN (Cloudflare), one CI server (Jenkins container).
* Mitigations: two origin servers behind a load balancer, a secondary DNS provider, health-checked failover records, CDN serving stale content if the origin is down, and keeping GitHub Actions as a CI fallback to Jenkins.

## Priority list (what I would do first)

1. Off-site, scheduled backups (cheap, biggest risk reduction).
2. Replica on a second machine/zone.
3. Two app instances behind a load balancer with health checks.
4. Automatic failover (Patroni/repmgr) and monitoring/alerts.
5. Second DNS provider and a documented DR runbook.

