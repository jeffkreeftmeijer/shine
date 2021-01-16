import gleam/atom.{Atom}
import gleam/dynamic.{Dynamic}

pub fn wrap(fun: fn() -> a) {
  fn() { rescue(fun) }
}

pub external fn rescue(fn() -> a) -> Result(a, tuple(Atom, Dynamic, Dynamic)) =
  "shine_external" "rescue"
