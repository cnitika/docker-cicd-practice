# Docker notes

## Container vs VM
- VM: each VM has its own guest OS and kernel, running on top of a hypervisor. Heavy, slow to boot, strong isolation.
- Container: shares the host kernel and isolates only the process and filesystem. Lightweight, starts in seconds.
- Isolation: VMs isolate more strongly; containers share the kernel, so a kernel exploit is a bigger risk.

## Concepts
- Image: a read-only template. Container: a running instance of an image.
- Dockerfile: the recipe for building an image (FROM, WORKDIR, COPY, RUN, CMD).
- Volume: keeps data even after the container is deleted (pgdata).
- Network: in Compose, services reach each other by name (app -> db).

## Compose + DB persistence
- App + PostgreSQL, with a healthcheck (pg_isready) and depends_on with service_healthy.
- Test: after down/up, the visits count was still there.
- Why run the DB outside Docker: easier backup/restore and tuning, replication/HA, and the DB's data lifecycle stays separate from the container's.
