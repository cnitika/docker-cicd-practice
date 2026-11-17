# Testing notes

- Smoke test: build ke baad basic check ki app chalti hai (curl localhost:3000).
- Regression test: naye change se purana kaam toot to nahi gaya (Jest tests har push par CI mein).
- Detailed testing: har function/edge case (jaise negative numbers wala test).
- Code coverage: tests code ka kitna hissa chalate hain. CI mein `npm test -- --coverage`, report artifact ke roop mein upload.
- CI experience: test jaan-bujh kar tod kar CI fail dekha, phir fix kiya (commits "Break test on purpose" aur "Fix test").
