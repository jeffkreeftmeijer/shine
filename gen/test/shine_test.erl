-module(shine_test).
-compile(no_auto_import).

-export([start_test/0, start_with_failing_test/0, run_test/0]).

start_test() ->
    Suite = [{test_module, <<"test"/utf8>>, [fixtures:test()]}],
    gleam@should:equal(shine:start(Suite), 0).

start_with_failing_test() ->
    Suite = [{test_module, <<"test"/utf8>>, [fixtures:test_failing()]}],
    gleam@should:equal(shine:start(Suite), 1).

run_test() ->
    {ok, Stats} = shine@stats:start(),
    Suite = [{test_module, <<"test"/utf8>>, [fixtures:test()]}],
    [Test_module] = shine:run(Suite, Stats),
    [Test] = erlang:element(3, Test_module),
    gleam@should:equal(
        erlang:element(4, Test),
        {passed, {ok, gleam@dynamic:from(<<""/utf8>>)}}
    ).
