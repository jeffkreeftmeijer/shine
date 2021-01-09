import shine
import gleam/should

pub fn run_passing_test() {
  passing
  |> shine.run_test()
  |> should.be_ok()
}

pub fn run_failing_test() {
  failing
  |> shine.run_test()
  |> should.be_error()
}

fn passing() {
  1
  |> should.equal(1)
}

fn failing() {
  1
  |> should.equal(2)
}
