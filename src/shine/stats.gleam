import gleam/otp/actor
import gleam/otp/process
import shine/test

pub type TestStats {
  TestStats(tests: Int, failures: Int)
}

pub type Message {
  GetStats(reply_channel: process.Sender(TestStats))
  TestFinished(test: test.Test)
}

pub fn start() {
  actor.start(TestStats(tests: 0, failures: 0), handle_message)
}

pub fn stats(reporter) {
  actor.call(reporter, GetStats, 100)
}

pub fn test_finished(reporter, test) {
  actor.send(reporter, TestFinished(test))
}

fn handle_message(message, stats) {
  case message {
    GetStats(reply_channel: channel) -> {
      actor.send(channel, stats)
      actor.Continue(stats)
    }
    TestFinished(test) ->
      case test.state {
        test.Passed(_) ->
          actor.Continue(TestStats(
            tests: stats.tests + 1,
            failures: stats.failures,
          ))
        test.Failed(_) ->
          actor.Continue(TestStats(
            tests: stats.tests + 1,
            failures: stats.failures + 1,
          ))
      }
  }
}
