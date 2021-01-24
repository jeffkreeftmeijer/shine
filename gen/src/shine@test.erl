-module(shine@test).
-compile(no_auto_import).

-export([new/3, run/1]).

new(Module, Name, Fun) ->
    {test, Module, Name, upcoming, wrap(Fun)}.

run(Test) ->
    State = case (erlang:element(5, Test))() of
        {error, E} ->
            {failed, {error, E}};

        {ok, A} ->
            {passed, {ok, A}}
    end,
    erlang:setelement(4, Test, State).

wrap(Fun) ->
    fun() -> shine_external:rescue(Fun) end.
