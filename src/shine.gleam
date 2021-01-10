import gleam/function.{Exception}
import gleam/list
import gleam/io

pub fn init(state) {
  assert Ok(state) = rebar3_shine_init(state)
  Ok(state)
}

pub fn run_suite(
  suite: List(tuple(String, List(fn() -> Result(a, Exception)))),
) -> List(tuple(String, List(Result(a, Exception)))) {
  list.map(
    suite,
    fn(test_case) {
      let tuple(module, tests) = test_case
      tuple(module, run_case(tests))
    },
  )
}

pub fn run_case(
  tests: List(fn() -> Result(a, Exception)),
) -> List(Result(a, Exception)) {
  list.map(tests, run_test)
}

pub fn run_test(test: fn() -> Result(a, Exception)) -> Result(a, Exception) {
  case test() {
    Error(e) -> {
      io.println("F")
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
