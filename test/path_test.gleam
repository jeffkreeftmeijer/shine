import gleam/should
import path

pub fn basename_test() {
  path.basename("/foo/bar.txt")
  |> should.equal("bar.txt")
}

pub fn basename_without_extension_test() {
  path.basename_without_extension("/baz/foo.txt", ".txt")
  |> should.equal("foo")
}

pub fn rootname_test() {
  path.rootname("/bar/baz.txt")
  |> should.equal("/bar/baz")
}

pub fn wildcard_test() {
  path.wildcard("LIC*")
  |> should.equal(["LICENSE"])
}
