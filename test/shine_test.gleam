import shine
import gleam/should
import gleam/dynamic
import gleam/function

pub fn run_passing_test() {
  passing
  |> shine.run_test()
  |> should.be_ok()
}

pub fn run_failing_test() {
  failing
  |> shine.run_test()
  |> should.be_error()
}

pub fn run_case_test() {
  let test_case = [passing]
  assert [result] = shine.run_case(test_case)

  result
  |> should.be_ok()
}

pub fn run_suite_test() {
  let suite = [tuple("test", [passing])]
  assert [tuple("test", [result])] = shine.run_suite(suite)

  result
  |> should.be_ok()
}

pub fn passing() {
  Ok(Nil)
}

pub fn failing() {
  Error(function.Errored(dynamic.from("")))
}
