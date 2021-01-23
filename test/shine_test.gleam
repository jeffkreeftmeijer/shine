import shine.{TestModule}
import shine/test.{Passed}
import gleam/should
import gleam/dynamic
import fixtures

pub fn run_test() {
  let suite = [TestModule(name: "test", tests: [fixtures.test()])]
  let [test_module] = shine.run(suite)
  let [test] = test_module.tests

  test.state
  |> should.equal(Passed)
}
