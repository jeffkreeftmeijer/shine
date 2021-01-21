import gleam/dynamic
import shine/test

pub fn test() {
  test.new("shine_test", "passing_test", fn() { dynamic.from("") })
}
