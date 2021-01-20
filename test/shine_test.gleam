import shine.{TestModule}
import shine/test
import gleam/should
import gleam/dynamic

pub fn run_test_module_test() {
  let test_module =
    TestModule(
      name: "test",
      tests: [test.new("shine_test", "passing_test", passing)],
    )
  assert tuple("test", [result]) = shine.run_test_module(test_module)

  result
  |> should.equal(Ok(dynamic.from("")))
}

pub fn run_suite_test() {
  let suite = [
    TestModule(
      name: "test",
      tests: [test.new("shine_test", "passing_test", passing)],
    ),
  ]
  assert [tuple("test", [result])] = shine.run_suite(suite)

  result
  |> should.equal(Ok(dynamic.from("")))
}

pub fn passing() {
  dynamic.from("")
}
