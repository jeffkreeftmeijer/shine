-module(rebar3_shine_test).
-include_lib("eunit/include/eunit.hrl").

-include("src/shine_Test.hrl").
-include("src/shine_TestModule.hrl").

extract_test_modules_test() ->
    Paths = ["gen/test/fixtures@passing_test_module.erl"],
    [TestModule] = rebar3_shine:extract_test_modules(Paths),
    [Test] = TestModule#test_module.tests,

    ?assertEqual("fixtures@passing_test_module", TestModule#test_module.name),
    ?assertEqual({ok, nil}, (Test#test.run)()).

extract_tests_passing_test() ->
    Module = fixtures@passing_test_module,
    [Test] = rebar3_shine:extract_tests(Module),

    ?assertEqual("passing_test", Test#test.name),
    ?assertEqual({ok, nil}, (Test#test.run)()).
