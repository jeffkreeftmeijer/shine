import gleam/function.{Exception}
import gleam/list
import gleam/io
import gleam/dynamic.{Dynamic}
import gleam/string

pub type Test {
  Test(module: String, name: String, run: fn() -> Result(Dynamic, Exception))
}

pub type TestModule {
  TestModule(name: String, tests: List(Test))
}

pub fn init(state) {
  assert Ok(state) = rebar3_shine_init(state)
  Ok(state)
}

pub fn run_suite(
  suite: List(TestModule),
) -> List(tuple(String, List(Result(Dynamic, Exception)))) {
  list.map(suite, run_test_module)
}

pub fn run_test_module(
  test_module: TestModule,
) -> tuple(String, List(Result(Dynamic, Exception))) {
  tuple(test_module.name, list.map(test_module.tests, run_test))
}

pub fn run_test(test: Test) -> Result(Dynamic, Exception) {
  case test.run() {
    Error(e) -> {
      test.module
      |> string.append(".")
      |> string.append(test.name)
      |> string.append("/0:")
      |> io.println
      io.debug(e)
      Error(e)
    }
    Ok(a) -> {
      io.print(".")
      Ok(a)
    }
  }
}

external fn rebar3_shine_init(state) -> state =
  "rebar3_shine" "init"
