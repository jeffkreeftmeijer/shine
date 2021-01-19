import gleam/list
import shine/test.{Test}

pub type TestModule {
  TestModule(name: String, tests: List(Test))
}

pub fn init(state) {
  assert Ok(state) = rebar3_shine_init(state)
  Ok(state)
}

pub fn run_suite(suite: List(TestModule)) -> List(TestModule) {
  list.map(
    suite,
    fn(test_module: TestModule) {
      TestModule(..test_module, tests: list.map(test_module.tests, test.run))
    },
  )
}

external fn rebar3_shine_init(state) -> state =
  "rebar3_shine" "init"
