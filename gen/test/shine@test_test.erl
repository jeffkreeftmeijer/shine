-module(shine@test_test).
-compile(no_auto_import).

-export([run_test/0, wrap_passing_test/0, new_failing_test/0]).

run_test() ->
    Test = shine@test:run(fixtures:test()),
    {passed, {ok, Dynamic_result}} = erlang:element(4, Test),
    {ok, Result} = gleam@dynamic:string(Dynamic_result),
    gleam@should:equal(Result, <<""/utf8>>).

wrap_passing_test() ->
    T = shine@test:new(
        <<"module"/utf8>>,
        <<"name"/utf8>>,
        fun() -> gleam@should:equal(1, 1) end
    ),
    gleam@should:equal(erlang:element(2, T), <<"module"/utf8>>),
    gleam@should:equal(erlang:element(3, T), <<"name"/utf8>>),
    gleam@should:be_ok((erlang:element(5, T))()).

new_failing_test() ->
    T = shine@test:new(
        <<"module"/utf8>>,
        <<"name"/utf8>>,
        fun() -> gleam@should:equal(1, 2) end
    ),
    {error, {Kind, Error, Stack}} = (erlang:element(5, T))(),
    {ok, {Dynamic_kind, _}} = gleam@dynamic:tuple2(Error),
    {ok, Error_kind} = gleam@dynamic:atom(Dynamic_kind),
    gleam@should:equal(gleam@atom:to_string(Kind), <<"errored"/utf8>>),
    gleam@should:equal(gleam@atom:to_string(Error_kind), <<"assertEqual"/utf8>>),
    gleam@should:be_false(gleam@list:is_empty(Stack)).
