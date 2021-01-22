import gleam/dynamic
import gleam/should
import shine/test
import shine/stats.{TestStats}

pub fn test() {
  test.new("shine_test", "passing_test", fn() { dynamic.from("") })
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

pub fn stats() {
  TestStats(tests: 3, failures: 2)
}

pub fn stats_singular() {
  TestStats(tests: 1, failures: 1)
}
