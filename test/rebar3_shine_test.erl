-module(rebar3_shine_test).
-include_lib("eunit/include/eunit.hrl").
 
extract_tests_test() ->
    Module = fixtures@passing_test_module,
    [Test] = rebar3_shine:extract_tests(Module),
    ?assertEqual({ok, nil}, Test()).
