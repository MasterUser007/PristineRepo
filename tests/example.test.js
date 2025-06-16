const sum = (a, b) => a + b;
test('Basic addition', () => {
  expect(sum(2, 3)).toBe(5);
});
test('Handles negative numbers', () => {
  expect(sum(-2, -3)).toBe(-5);
});
test('Verifies object structure', () => {
  expect({ name: 'Lee', age: 30 }).toMatchObject({ name: 'Lee' });
});
