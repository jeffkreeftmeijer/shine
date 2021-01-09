import gleam/function.{Exception}
import gleam/list

pub fn run_case(tests: List(fn() -> a)) -> List(Result(a, Exception)) {
  list.map(tests, run_test)
}

pub fn run_test(test: fn() -> a) -> Result(a, Exception) {
  function.rescue(test)
}
