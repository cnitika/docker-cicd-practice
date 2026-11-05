#!/bin/bash
set -e

cd "$(dirname "$0")/app"
npm ci
npm run build --if-present
npm test
npx --yes cowsay "Build done"
