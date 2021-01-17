-module(test_project_erlang_test).
-include_lib("eunit/include/eunit.hrl").

hello_world_test() ->
    ?assertEqual("Hello world!", test_project_erlang:hello_world()).

