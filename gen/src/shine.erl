-module(shine).
-compile(no_auto_import).

-export([init/1, start/1, run/2]).

init(State) ->
    {ok, State@1} = rebar3_shine:init(State),
    {ok, State@1}.

start(Suite) ->
    {ok, Stats} = shine@stats:start(),
    run(Suite, Stats),
    Stats@1 = shine@stats:stats(Stats),
    shine@formatter:print_stats(Stats@1),
    erlang:element(3, Stats@1).

run(Suite, Stats) ->
    gleam@list:map(
        Suite,
        fun(Test_module) ->
            erlang:setelement(
                3,
                Test_module,
                gleam@list:map(
                    erlang:element(3, Test_module),
                    fun(Test) -> Test@1 = shine@test:run(Test),
                        shine@stats:test_finished(Stats, Test@1),
                        shine@formatter:print_test(Test@1) end
                )
            )
        end
    ).
