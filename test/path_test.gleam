import gleam/should
import path

pub fn rootname_test() {
  path.rootname("/bar/baz.txt")
  |> should.equal("/bar/baz")
}

pub fn wildcard_test() {
  path.wildcard("LIC*")
  |> should.equal(["LICENSE"])
}
