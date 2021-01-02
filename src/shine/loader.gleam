import gleam/atom.{Atom}
import gleam/list
import gleam/map
import path

pub fn load_tests(
  paths: List(String),
) -> List(tuple(Atom, List(tuple(Atom, Int)))) {
  paths
  |> list.map(fn(path: String) {
    let module = path_to_module_name(path)
    tuple(module, module_exports(module))
  })
}

fn module_exports(module: Atom) -> List(tuple(Atom, Int)) {
  assert Ok(exports) =
    module
    |> get_module_info()
    |> map.from_list()
    |> map.get(atom.create_from_string("exports"))

  exports
}

fn path_to_module_name(path: String) -> Atom {
  path
  |> path.basename()
  |> path.rootname()
  |> atom.create_from_string()
}

external fn get_module_info(
  module: Atom,
) -> List(tuple(Atom, List(tuple(key, value)))) =
  "erlang" "get_module_info"
