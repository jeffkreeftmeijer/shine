import shine.{TestModule}
import shine/test.{Passed}
import shine/stats
import gleam/should
import gleam/dynamic
import fixtures

pub fn run_test() {
  let Ok(stats) = stats.start()
  let suite = [TestModule(name: "test", tests: [fixtures.test()])]
  let [test_module] = shine.run(suite, stats)
  let [test] = test_module.tests

  test.state
  |> should.equal(Passed(Ok(dynamic.from(""))))
}
