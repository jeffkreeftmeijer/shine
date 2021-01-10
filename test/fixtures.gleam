import gleam/should

pub fn passing_test() {
  1
  |> should.equal(1)
}

pub fn failing_test() {
  1
  |> should.equal(2)
}
