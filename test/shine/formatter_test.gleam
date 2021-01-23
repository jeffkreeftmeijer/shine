import gleam/should
import gleam/string
import shine/formatter
import fixtures

pub fn format_passed_test() {
  fixtures.test_passed()
  |> formatter.format()
  |> should.equal(".")
}

pub fn format_raised_test() {
  fixtures.test_raised()
  |> formatter.format()
  |> string.starts_with(
    "F\nshine_test:raising_test/0:\n{errored,\n    {assertEqual",
  )
  |> should.be_true()
}
