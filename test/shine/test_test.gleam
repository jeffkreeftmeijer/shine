import shine/test.{Passed, Upcoming}
import gleam/should
import gleam/function
import gleam/dynamic
import gleam/atom
import fixtures

pub fn run_test() {
  test.run(fixtures.test()).state
  |> should.equal(Passed)
}

pub fn new_passing_test() {
  let t =
    test.new(
      "module",
      "name",
      fn() {
        1
        |> should.equal(1)
      },
    )

  t.module
  |> should.equal("module")

  t.name
  |> should.equal("name")

  t.run()
  |> should.equal(Ok(dynamic.from(atom.create_from_string("ok"))))
}

pub fn new_failing_test() {
  let t =
    test.new(
      "module",
      "name",
      fn() {
        1
        |> should.equal(2)
      },
    )

  let Error(tuple(kind, error, stack)) = t.run()

  let Ok(tuple(dynamic_kind, _)) = dynamic.tuple2(error)
  let Ok(error_kind) = dynamic.atom(dynamic_kind)

  kind
  |> atom.to_string()
  |> should.equal("errored")

  error_kind
  |> atom.to_string()
  |> should.equal("assertEqual")

  stack
  |> dynamic.list
  |> should.be_ok
}
