import gleam/atom.{Atom}
import gleam/list
import gleam/dynamic.{Dynamic}
import shine/test.{Test}

pub type TestModule {
  TestModule(name: String, tests: List(Test))
}

pub fn init(state) {
  assert Ok(state) = rebar3_shine_init(state)
  Ok(state)
}

pub fn run_suite(
  suite: List(TestModule),
) -> List(tuple(String, List(Result(Dynamic, tuple(Atom, Dynamic, Dynamic))))) {
  list.map(suite, run_test_module)
}

pub fn run_test_module(
  test_module: TestModule,
) -> tuple(String, List(Result(Dynamic, tuple(Atom, Dynamic, Dynamic)))) {
  tuple(test_module.name, list.map(test_module.tests, test.run))
}

external fn rebar3_shine_init(state) -> state =
  "rebar3_shine" "init"
