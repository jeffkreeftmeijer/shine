import gleam/function.{Exception}

pub fn wrap(fun: fn() -> a) -> fn() -> Result(a, Exception) {
  fn() { function.rescue(fun) }
}
