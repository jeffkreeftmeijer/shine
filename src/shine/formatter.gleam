import gleam/io
import shine/test.{Failed, Passed, Test}

pub fn print(test: Test) {
  test
  |> format()
  |> io.print()

  test
}

pub fn format(test: Test) {
  case test.state {
    Passed(_) -> "."
    Failed(_) -> "F"
  }
}
