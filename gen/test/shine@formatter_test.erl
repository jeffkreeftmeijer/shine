-module(shine@formatter_test).
-compile(no_auto_import).

-export([format_passed_test/0, format_failed_test/0, format_report_test/0, format_report_singular_test/0]).

format_passed_test() ->
    gleam@should:equal(
        shine@formatter:format_test(fixtures:test_passed()),
        <<"."/utf8>>
    ).

format_failed_test() ->
    gleam@should:be_true(
        gleam@string:starts_with(
            shine@formatter:format_test(fixtures:test_failed()),
            <<"F\nshine_test:failing_test/0:\n{errored,\n    {assertEqual"/utf8>>
        )
    ).

format_report_test() ->
    gleam@should:equal(
        shine@formatter:format_stats(fixtures:stats()),
        <<"\n3 tests, 2 failures.\n"/utf8>>
    ).

format_report_singular_test() ->
    gleam@should:equal(
        shine@formatter:format_stats(fixtures:stats_singular()),
        <<"\n1 test, 1 failure.\n"/utf8>>
    ).
