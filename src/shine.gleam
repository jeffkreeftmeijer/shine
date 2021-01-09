import gleam/function.{Exception}
import gleam/list
import gleam/io

pub fn run_suite(
  suite: List(tuple(String, List(fn() -> a))),
) -> List(tuple(String, List(Result(a, Exception)))) {
  list.map(
    suite,
    fn(test_case) {
      let tuple(module, tests) = test_case
      tuple(module, run_case(tests))
    },
  )
}

pub fn run_case(tests: List(fn() -> a)) -> List(Result(a, Exception)) {
  list.map(tests, run_test)
}

pub fn run_test(test: fn() -> a) -> Result(a, Exception) {
  case function.rescue(test) {
    Error(e) -> {
      io.print("F")
      Error(e)
    }
    Ok(i) -> {
      io.print(".")
      Ok(i)
    }
  }
}
