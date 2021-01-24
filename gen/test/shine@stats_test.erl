-module(shine@stats_test).
-compile(no_auto_import).

-export([start_test/0, stats_test/0, test_finished_passed_test/0, test_finished_failed_test/0]).

start_test() ->
    {ok, Stats} = shine@stats:start(),
    gleam@should:be_true(
        gleam@otp@process:is_alive(gleam@otp@process:pid(Stats))
    ).

stats_test() ->
    {ok, Stats} = shine@stats:start(),
    gleam@should:equal(shine@stats:stats(Stats), {test_stats, 0, 0}).

test_finished_passed_test() ->
    {ok, Stats} = shine@stats:start(),
    shine@stats:test_finished(Stats, fixtures:test_passed()),
    gleam@should:equal(shine@stats:stats(Stats), {test_stats, 1, 0}).

test_finished_failed_test() ->
    {ok, Stats} = shine@stats:start(),
    shine@stats:test_finished(Stats, fixtures:test_failed()),
    gleam@should:equal(shine@stats:stats(Stats), {test_stats, 1, 1}).
