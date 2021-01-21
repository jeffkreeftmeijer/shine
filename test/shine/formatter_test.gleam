import gleam/should
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
  |> should.equal("F")
}
