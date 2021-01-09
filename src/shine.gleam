import gleam/function.{Exception}

pub fn run_test(test: fn() -> a) -> Result(a, Exception) {
  function.rescue(test)
}
