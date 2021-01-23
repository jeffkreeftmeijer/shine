import gleam/otp/process
import gleam/should
import shine/stats.{TestStats}
import fixtures

pub fn start_test() {
  assert Ok(stats) = stats.start()

  stats
  |> process.pid()
  |> process.is_alive()
  |> should.be_true()
}

pub fn stats_test() {
  assert Ok(stats) = stats.start()

  stats
  |> stats.stats()
  |> should.equal(TestStats(tests: 0, failures: 0))
}

pub fn test_finished_passed_test() {
  assert Ok(stats) = stats.start()

  stats.test_finished(stats, fixtures.test_passed())

  stats
  |> stats.stats()
  |> should.equal(TestStats(tests: 1, failures: 0))
}

pub fn test_finished_failed_test() {
  assert Ok(stats) = stats.start()

  stats.test_finished(stats, fixtures.test_failed())

  stats
  |> stats.stats()
  |> should.equal(TestStats(tests: 1, failures: 1))
}
