const sum = require('./sum');

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(4);
});

test('adds negative numbers', () => {
  expect(sum(-1, -2)).toBe(-3);
});
