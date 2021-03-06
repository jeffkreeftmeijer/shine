import gleam/atom.{Atom}
import gleam/dynamic.{Dynamic}
import gleam/io
import gleam/string

pub type TestState {
  Upcoming
  Passed(Result(Dynamic, tuple(Atom, Dynamic, List(Dynamic))))
  Failed(Result(Dynamic, tuple(Atom, Dynamic, List(Dynamic))))
}

pub type Test {
  Test(
    module: String,
    name: String,
    state: TestState,
    run: fn() -> Result(Dynamic, tuple(Atom, Dynamic, List(Dynamic))),
  )
}

pub fn new(module: String, name: String, fun: fn() -> a) -> Test {
  Test(module: module, name: name, state: Upcoming, run: wrap(fun))
}

pub fn run(test: Test) -> Test {
  let state = case test.run() {
    Error(e) -> Failed(Error(e))
    Ok(a) -> Passed(Ok(a))
  }

  Test(..test, state: state)
}

fn wrap(
  fun: fn() -> a,
) -> fn() -> Result(Dynamic, tuple(Atom, Dynamic, List(Dynamic))) {
  fn() { rescue(fun) }
}

external fn rescue(
  fn() -> a,
) -> Result(Dynamic, tuple(Atom, Dynamic, List(Dynamic))) =
  "shine_external" "rescue"
