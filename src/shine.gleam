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
  list.map(suite, run_test_module)
}

pub fn run_test_module(test_module: TestModule) -> TestModule {
  TestModule(name: test_module.name, tests: list.map(testmodule.tests, test.run))
}

external fn rebar3_shine_init(state) -> state =
  "rebar3_shine" "init"
