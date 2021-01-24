-module(shine@formatter).
-compile(no_auto_import).

-export([print_test/1, format_test/1, print_stats/1, format_stats/1]).

print_test(Test) ->
    gleam@io:print(format_test(Test)),
    Test.

format_test(Test) ->
    case erlang:element(4, Test) of
        {passed, _} ->
            <<"."/utf8>>;

        {failed, {error, Error}} ->
            Test_name = test_name(Test),
            Result = inspect(Error),
            gleam@string:append(
                gleam@string:append(
                    gleam@string:append(
                        gleam@string:append(<<"F\n"/utf8>>, Test_name),
                        <<":\n"/utf8>>
                    ),
                    Result
                ),
                <<"\n"/utf8>>
            )
    end.

print_stats(Stats) ->
    gleam@io:print(format_stats(Stats)),
    Stats.

format_stats(Stats) ->
    gleam@string:append(
        gleam@string:append(
            gleam@string:append(
                gleam@string:append(
                    <<"\n"/utf8>>,
                    pluralize(erlang:element(2, Stats), <<"test"/utf8>>)
                ),
                <<", "/utf8>>
            ),
            pluralize(erlang:element(3, Stats), <<"failure"/utf8>>)
        ),
        <<".\n"/utf8>>
    ).

test_name(Test) ->
    gleam@string:append(
        gleam@string:append(
            gleam@string:append(erlang:element(2, Test), <<":"/utf8>>),
            erlang:element(3, Test)
        ),
        <<"/0"/utf8>>
    ).

inspect(Term) ->
    [Char_list, _] = io_lib:format(<<"~tp\n"/utf8>>, [Term]),
    erlang:list_to_binary(Char_list).

pluralize(Count, Singular) ->
    case Count of
        1 ->
            gleam@string:append(<<"1 "/utf8>>, Singular);

        _ ->
            gleam@string:append(
                gleam@string:append(
                    gleam@string:append(
                        gleam@int:to_string(Count),
                        <<" "/utf8>>
                    ),
                    Singular
                ),
                <<"s"/utf8>>
            )
    end.
