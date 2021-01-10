import shine.{Test, TestModule}
import gleam/should
import gleam/dynamic
import gleam/function

pub fn run_passing_test() {
  Test(run: passing)
  |> shine.run_test()
  |> should.be_ok()
}

pub fn run_failing_test() {
  Test(run: failing)
  |> shine.run_test()
  |> should.be_error()
}

pub fn run_test_module_test() {
  let test_module = TestModule(name: "test", tests: [Test(run: passing)])
  assert tuple("test", [result]) = shine.run_test_module(test_module)

  result
  |> should.be_ok()
}

pub fn run_suite_test() {
  let suite = [TestModule(name: "test", tests: [Test(run: passing)])]
  assert [tuple("test", [result])] = shine.run_suite(suite)

  result
  |> should.be_ok()
}

pub fn passing() {
  Ok(dynamic.from(""))
}

pub fn failing() {
  Error(function.Errored(dynamic.from("")))
}
