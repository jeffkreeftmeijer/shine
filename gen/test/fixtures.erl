-module(fixtures).
-compile(no_auto_import).

-export([test/0, test_failing/0, test_passed/0, test_failed/0, stats/0, stats_singular/0]).

test() ->
    shine@test:new(
        <<"shine_test"/utf8>>,
        <<"passing_test"/utf8>>,
        fun() -> gleam@dynamic:from(<<""/utf8>>) end
    ).

test_failing() ->
    shine@test:new(
        <<"shine_test"/utf8>>,
        <<"failing_test"/utf8>>,
        fun() -> gleam@should:equal(1, 2) end
    ).

test_passed() ->
    shine@test:run(test()).

test_failed() ->
    shine@test:run(test_failing()).

stats() ->
    {test_stats, 3, 2}.

stats_singular() ->
    {test_stats, 1, 1}.
