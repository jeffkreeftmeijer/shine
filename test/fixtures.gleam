import gleam/should
import shine/test

pub fn test() {
  test.new(
    "shine_test",
    "passing_test",
    fn() {
      1
      |> should.equal(1)
    },
  )
}

pub fn test_passed() {
  test()
  |> test.run()
}

pub fn test_failed() {
  test.new(
    "shine_test",
    "failing_test",
    fn() {
      1
      |> should.equal(2)
    },
  )
  |> test.run()
}
