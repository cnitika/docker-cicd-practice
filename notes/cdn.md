# Cloudflare / CDN notes

## How a CDN serves static content
- DNS resolves the site name to the nearest Cloudflare edge (anycast).
- The edge server returns the file from its cache if it has it (HIT). Otherwise it fetches from the origin once, stores it (MISS), and serves later requests from cache.
- Benefits: lower latency (closer to the user), less load on the origin, protection if the origin is slow or down.

## Caching
- Controlled by Cache-Control headers and file type. Here the response had `max-age=0, must-revalidate` with an ETag, so the edge revalidates with the origin but still reports a cache HIT.

## DNS basics
- DNS maps a name to an IP. Using a CDN means the name points to the CDN's edge, not directly to my server, which also hides the origin IP.
- TTL decides how long resolvers cache the answer.

## Test (static site on Cloudflare, tested from Hisar/India)
- URL: https://shrill-feather-c76e.cnitika040.workers.dev
- File: 2 MB test file (big.jpg), 5 sequential curl runs.
- Run 1: 1.83 s total (ttfb 1.62 s). Runs 2-5: 0.70-0.92 s (ttfb 0.49-0.70 s).
- Headers: `Server: cloudflare`, `CF-Cache-Status: HIT`, `CF-RAY: ...-DEL` (served from the Delhi edge).
- Caveat: run 1 includes DNS and TLS setup, and 2 MB transfer time depends largely on my own bandwidth. There was no non-CDN origin to compare against, so this shows caching and edge serving, not a before/after speedup.
