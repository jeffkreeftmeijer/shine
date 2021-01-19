import shine.{TestModule}
import shine/test.{Test}
import gleam/should
import gleam/dynamic

pub fn run_test_module_test() {
  let test_module =
    TestModule(
      name: "test",
      tests: [Test(module: "shine_test", name: "passing_test", run: passing)],
    )
  assert tuple("test", [result]) = shine.run_test_module(test_module)

  result
  |> should.be_ok()
}

pub fn run_suite_test() {
  let suite = [
    TestModule(
      name: "test",
      tests: [Test(module: "shine_test", name: "passing_test", run: passing)],
    ),
  ]
  assert [tuple("test", [result])] = shine.run_suite(suite)

  result
  |> should.be_ok()
}

pub fn passing() {
  Ok(dynamic.from(""))
}
