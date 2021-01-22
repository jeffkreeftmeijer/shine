import gleam/io
import gleam/string
import shine/test.{Failed, Passed, Test}

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

external fn io_lib_format(format, data) -> List(a) =
  "io_lib" "format"

external fn char_list_to_string(a) -> String =
  "erlang" "list_to_binary"
