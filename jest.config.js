Set-Location "C:\Users\leebo\Desktop\PristineRepo"

$jestConfig = "jest.config.js"
if (-not (Test-Path $jestConfig)) {
@'
module.exports = {
  collectCoverage: true,
  coverageThreshold: {
    global: {
      branches: 95,
      functions: 95,
      lines: 95,
      statements: 95
    }
  }
};
