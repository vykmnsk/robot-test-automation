# Robot Test Automation

## Env Variables required:
* TA_WEB_URL
* TA_API_URL
* TA_USR
* TA_PWD

## Run tests:
Create directory "results"
```bash
mkdir results
```

Run __smoke__ tests
```bash
robot -d results -i smoke tests
```

Run all __Web__ (Selenium) tests
```bash
robot -d results tests/web
```

Run all __Web__ (Selenium) tests in Headless Mode tests
Note: Chrome version 65+ is required
```bash
robot -d results -v HEADLESS:yes tests/web
```

Run all __API__ tests
```bash
robot -d results tests/api
```

Re-run only tests failed in previous run 
```bash
robot -d results2 --rerunfailed results\output.xml tests
```

Check robot files for warnings/errors
```bash
python -m rflint -i RequireKeywordDocumentation -i RequireSuiteDocumentation -i RequireTestDocumentation -i TooFewKeywordSteps --configure LineTooLong:180 --configure TooManyTestSteps:50 tests
```