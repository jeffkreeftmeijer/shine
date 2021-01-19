import gleam/atom.{Atom}
import gleam/dynamic.{Dynamic}
import gleam/io
import gleam/string

pub type Test {
  Test(
    module: String,
    name: String,
    run: fn() -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)),
  )
}

pub fn new(module: String, name: String, fun: fn() -> a) -> Test {
  Test(module: module, name: name, run: wrap(fun))
}

pub fn run(test: Test) -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)) {
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

fn wrap(
  fun: fn() -> a,
) -> fn() -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)) {
  fn() { rescue(fun) }
}

external fn rescue(fn() -> a) -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)) =
  "shine_external" "rescue"
