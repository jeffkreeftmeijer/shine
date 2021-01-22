import gleam/int
import gleam/io
import gleam/string
import shine/test.{Failed, Passed, Test}
import shine/reporter.{TestStats}

pub fn print_test(test: Test) {
  test
  |> format_test()
  |> io.print()

  test
}

pub fn format_test(test: Test) {
  case test.state {
    Passed(_) -> "."
    Failed(Error(error)) -> {
      let test_name = test_name(test)
      let result = inspect(error)
      "F\n"
      |> string.append(test_name)
      |> string.append(":\n")
      |> string.append(result)
    }
  }
}

pub fn print_stats(stats: TestStats) {
  stats
  |> format_stats()
  |> io.print()

  stats
}

pub fn format_stats(stats: TestStats) {
  "\n"
  |> string.append(pluralize(stats.tests, "test"))
  |> string.append(", ")
  |> string.append(pluralize(stats.failures, "failure"))
  |> string.append(".")
}

fn test_name(test: Test) -> String {
  test.module
  |> string.append(":")
  |> string.append(test.name)
  |> string.append("/0")
}

fn inspect(term) -> String {
  let [char_list, _] = io_lib_format("~tp\n", [term])

  char_list_to_string(char_list)
}

fn pluralize(count: Int, singular: String) {
  case count {
    1 -> string.append("1 ", singular)
    _ ->
      count
      |> int.to_string()
      |> string.append(" ")
      |> string.append(singular)
      |> string.append("s")
  }
}

external fn io_lib_format(format, data) -> List(a) =
  "io_lib" "format"

external fn char_list_to_string(a) -> String =
  "erlang" "list_to_binary"
