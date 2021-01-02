import gleam/io
import gleam/atom
import gleam/list
import shine/loader

pub fn start() {
  loader.load_files()
  |> list.each(fn(test_case) {
    let tuple(module, tests) = test_case

    io.debug(module)
    list.each(tests, fn(test) { io.debug(test) })
  })
}
