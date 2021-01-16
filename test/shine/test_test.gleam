import shine/test
import gleam/should
import gleam/function.{Errored}
import gleam/dynamic
import gleam/atom

pub fn wrap_passing_test() {
  test.wrap(fn() {
    1
    |> should.equal(1)
  })()
  |> should.be_ok
}

pub fn wrap_failing_test() {
  let Error(Errored(error)) =
    test.wrap(fn() {
      1
      |> should.equal(2)
    })()

  let Ok(tuple(dynamic_kind, _)) = dynamic.tuple2(error)
  let Ok(kind) = dynamic.atom(dynamic_kind)

  kind
  |> atom.to_string()
  |> should.equal("assertEqual")
}