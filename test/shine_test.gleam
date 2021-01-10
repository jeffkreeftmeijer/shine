import shine
import gleam/should
import fixtures

pub fn run_passing_test() {
  fixtures.passing_test
  |> shine.run_test()
  |> should.be_ok()
}

pub fn run_failing_test() {
  fixtures.failing_test
  |> shine.run_test()
  |> should.be_error()
}

pub fn run_case_test() {
  let test_case = [fixtures.passing_test]
  assert [result] = shine.run_case(test_case)

  result
  |> should.be_ok()
}

pub fn run_suite_test() {
  let suite = [tuple("test", [fixtures.passing_test])]
  assert [tuple("test", [result])] = shine.run_suite(suite)

  result
  |> should.be_ok()
}
