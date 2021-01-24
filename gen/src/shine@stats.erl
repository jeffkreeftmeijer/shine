-module(shine@stats).
-compile(no_auto_import).

-export([start/0, stats/1, test_finished/2]).

start() ->
    gleam@otp@actor:start({test_stats, 0, 0}, fun handle_message/2).

stats(Reporter) ->
    gleam@otp@actor:call(Reporter, fun(A) -> {get_stats, A} end, 100).

test_finished(Reporter, Test) ->
    gleam@otp@actor:send(Reporter, {test_finished, Test}).

handle_message(Message, Stats) ->
    case Message of
        {get_stats, Channel} ->
            gleam@otp@actor:send(Channel, Stats),
            {continue, Stats};

        {test_finished, Test} ->
            case erlang:element(4, Test) of
                {passed, _} ->
                    {continue,
                     {test_stats,
                      erlang:element(2, Stats)
                      + 1,
                      erlang:element(3, Stats)}};

                {failed, _} ->
                    {continue,
                     {test_stats,
                      erlang:element(2, Stats)
                      + 1,
                      erlang:element(3, Stats)
                      + 1}}
            end
    end.
