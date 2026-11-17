# Docker notes

## Container vs VM
- VM: har VM ka apna guest OS + kernel, hypervisor ke upar. Heavy, boot slow, isolation strong.
- Container: host kernel share karta hai, sirf process + filesystem isolate hota hai. Light, seconds mein start.
- Isolation: VM zyada strong; container mein kernel shared hone se risk zyada.

## Concepts
- Image: read-only template. Container: image ka running instance.
- Dockerfile: image banane ki recipe (FROM, WORKDIR, COPY, RUN, CMD).
- Volume: container delete hone par bhi data bachata hai (pgdata).
- Network: compose mein services naam se baat karti hain (app -> db).

## Compose + DB persistence
- app + postgres, healthcheck (pg_isready), depends_on service_healthy.
- Test: down/up ke baad visits count bacha raha.
- DB ko Docker se bahar kyun: backup/restore aur tuning aasan, replication/HA, container ka lifecycle data se alag.
