import gleam/list
import shine/test.{Test}
import shine/formatter
import shine/stats
import gleam/otp/process

pub type TestModule {
  TestModule(name: String, tests: List(Test))
}

pub fn init(state) {
  assert Ok(state) = rebar3_shine_init(state)
  Ok(state)
}

pub fn start(suite: List(TestModule)) -> Int {
  let Ok(stats) = stats.start()

  run(suite, stats)

  let stats = stats.stats(stats)
  formatter.print_stats(stats)

  stats.failures
}

pub fn run(
  suite: List(TestModule),
  stats: process.Sender(stats.Message),
) -> List(TestModule) {
  list.map(
    suite,
    fn(test_module: TestModule) {
      TestModule(
        ..test_module,
        tests: list.map(
          test_module.tests,
          fn(test) {
            let test = test.run(test)

            stats.test_finished(stats, test)
            formatter.print_test(test)
          },
        ),
      )
    },
  )
}

external fn rebar3_shine_init(state) -> state =
  "rebar3_shine" "init"
