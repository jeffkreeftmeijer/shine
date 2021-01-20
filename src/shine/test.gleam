import gleam/atom.{Atom}
import gleam/dynamic.{Dynamic}
import gleam/io
import gleam/string

pub type TestState {
  Upcoming
  Passed(Result(Dynamic, tuple(Atom, Dynamic, Dynamic)))
  Failed(Result(Dynamic, tuple(Atom, Dynamic, Dynamic)))
}

pub type Test {
  Test(
    module: String,
    name: String,
    state: TestState,
    run: fn() -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)),
  )
}

pub fn new(module: String, name: String, fun: fn() -> a) -> Test {
  Test(module: module, name: name, state: Upcoming, run: wrap(fun))
}

pub fn run(test: Test) -> Test {
  let state = case test.run() {
    Error(e) -> {
      test.module
      |> string.append(".")
      |> string.append(test.name)
      |> string.append("/0:")
      |> io.println
      io.debug(e)
      Failed(Error(e))
    }
    Ok(a) -> {
      io.print(".")
      Passed(Ok(a))
    }
  }

  Test(module: test.module, name: test.name, state: state, run: test.run)
}

fn wrap(
  fun: fn() -> a,
) -> fn() -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)) {
  fn() { rescue(fun) }
}

external fn rescue(fn() -> a) -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)) =
  "shine_external" "rescue"
