# Testing notes

- Smoke test: a basic check after build that the app runs (curl localhost:3000).
- Regression test: checks that a new change did not break old behavior (Jest tests run on every push in CI).
- Detailed testing: covers every function and edge case (for example, the negative numbers test).
- Code coverage: how much of the code the tests execute. CI runs `npm test -- --coverage` and uploads the report as an artifact.
- CI experience: I broke a test on purpose to see CI fail, then fixed it (commits "Break test on purpose" and "Fix test").
