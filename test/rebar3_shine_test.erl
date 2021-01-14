-module(rebar3_shine_test).
-include_lib("eunit/include/eunit.hrl").

extract_test_modules_test() ->
    Paths = ["gen/test/fixtures@passing_test_module.erl"],
    [{test_module, "fixtures@passing_test_module", [{test, Test}]}] = rebar3_shine:extract_test_modules(Paths),
    ?assertEqual({ok, nil}, Test()).

extract_tests_passing_test() ->
    Module = fixtures@passing_test_module,
    [{test, Test}] = rebar3_shine:extract_tests(Module),
    ?assertEqual({ok, nil}, Test()).
