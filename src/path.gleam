import gleam/atom
import gleam/list

pub external fn basename(String) -> String =
  "filename" "basename"

pub external fn basename_without_extension(String, String) -> String =
  "filename" "basename"

pub external fn rootname(String) -> String =
  "filename" "rootname"

pub fn wildcard(pattern: String) -> List(String) {
  pattern
  |> string_to_char_list()
  |> erl_wildcard()
  |> list.map(char_list_to_string)
}

external type CharList

external fn erl_wildcard(CharList) -> List(CharList) =
  "filelib" "wildcard"

external fn string_to_char_list(String) -> CharList =
  "erlang" "binary_to_list"

external fn char_list_to_string(CharList) -> String =
  "erlang" "list_to_binary"
