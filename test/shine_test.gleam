import shine.{TestModule}
import shine/test.{Passed}
import shine/stats
import gleam/should
import gleam/dynamic
import fixtures

pub fn start_test() {
  let suite = [TestModule(name: "test", tests: [fixtures.test()])]

  shine.start(suite)
  |> should.equal(0)
}

pub fn start_with_failing_test() {
  let suite = [TestModule(name: "test", tests: [fixtures.test_failing()])]

  shine.start(suite)
  |> should.equal(1)
}

pub fn run_test() {
  let Ok(stats) = stats.start()
  let suite = [TestModule(name: "test", tests: [fixtures.test()])]
  let [test_module] = shine.run(suite, stats)
  let [test] = test_module.tests

  test.state
  |> should.equal(Passed(Ok(dynamic.from(""))))
}
