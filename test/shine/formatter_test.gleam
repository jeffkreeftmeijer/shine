import gleam/should
import gleam/string
import shine/formatter
import fixtures

pub fn format_passed_test() {
  fixtures.test_passed()
  |> formatter.format()
  |> should.equal(".")
}

pub fn format_failed_test() {
  fixtures.test_failed()
  |> formatter.format()
  |> string.starts_with(
    "F\nshine_test:failing_test/0:\n{errored,\n    {assertEqual",
  )
  |> should.be_true()
}