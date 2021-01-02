import gleam/atom
import gleam/io
import gleam/should
import shine/loader

pub fn load_tests_test() {
  let [tuple(module, [test, ..]), ..] =
    loader.load_tests(["test/path_test.gleam"])

  module
  |> should.equal(atom.create_from_string("path_test"))

  test
  |> should.equal(tuple(atom.create_from_string("basename_test"), 0))
}
