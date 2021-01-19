import gleam/atom.{Atom}
import gleam/dynamic.{Dynamic}

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

fn wrap(
  fun: fn() -> a,
) -> fn() -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)) {
  fn() { rescue(fun) }
}

external fn rescue(fn() -> a) -> Result(Dynamic, tuple(Atom, Dynamic, Dynamic)) =
  "shine_external" "rescue"
