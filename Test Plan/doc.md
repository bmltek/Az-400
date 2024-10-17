# links to Resources

[Manage flaky tests](https://learn.microsoft.com/en-us/azure/devops/pipelines/test/flaky-test-management?view=azure-devops)


## Azure Test Plans

- The below testing can be carried out:

Planned Manual testings
User acceptance testing
Capture test results

- You can get stakeholders feedback, with the help of fedback extension.
- You can integrate with Azure pipelines.
- You can get end to end traceability
  - The test cases and suites can be linked to the user stories features to provide end to end traceability.

## Test Level of Access

**Stakeholder** can only perform exploratory testing with the Test and feedback extension.
**Basic** - We can `Test execution`, `perform exploratory testing with the Test and feedback extension`, `Analyze and review tests`.

**Basic + Test Plans** -> can do all that `Basic` can do with `Test planning`

**Test Execution** - Run tests on any platform with Test runner.

**Test Planning** 

- Create test plans and test suites
- Manage test plan run settings
- Manage Configurations

**Analyze and review tests** 

- Create charts with various pivots like priority, configuration etc to track test progress
- browse test results
- Export test plans and test suites for review
- User Acceptance testing - Asign testd and invite by email

### Test Runner

You can run tested for your web and desktop applications.
You can mark tests as passed or failed.
The test outcomes can also gather results such as screen records and screen captures.

`Test and Feedback extension`
This is a browser-based extension that works with web applications.
We can get stakeholders feedback with the help of this extension.
The test outcomes can also gather results such as screen records and screen captures

## Test Plans

`Azure Test plans` is use to group test cases and test suites.

`Test Suites` - This is used to group test cases into seperate testing scenarios.

`Test cases` - This is used to define the actual steps required to test the application.

`Shared steps` - You ca shared steps that needs to be shared across test cases.

## how to create a test plan

- Organization settings -> billings -> subscribe (basic + test plan)
- Organization settings -> user -> admin user-name -> change access level -> select (basic + Test Plan)
- You can create a `static based suite`, `requirement based suite` or `query based suite`
  - We now have a suite created based on user stories.
  - create a new `test cases` within the test suite
  - We now have test cases linked to the work item (the user story selected)
  - Assign the test cased to test engineer
  - Go to the entire suite and `Assign testers to run all tests`
  - Give the user that want to run the test `Basic + plans` access level
  - The tester will login to run the test
