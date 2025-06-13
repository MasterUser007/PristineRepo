test("Basic addition", () => {
  expect(2 + 3).toBe(5);
});
test("Handles negative numbers", () => {
  expect(-2 + 3).toBe(1);
});
test("Verifies object structure", () => {
  const user = { name: "Lee", active: true };
  expect(user).toMatchObject({ name: "Lee" });
});
test("Array contains specific values", () => {
  const numbers = [1, 2, 3, 4, 5];
  expect(numbers).toContain(3);
});
test("Mock function is called", () => {
  const mockFn = jest.fn();
  mockFn();
  expect(mockFn).toHaveBeenCalled();
});
