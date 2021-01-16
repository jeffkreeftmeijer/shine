-module(shine_external).

-export([rescue/1]).

rescue(F) ->
    try
        {ok, F()}
    catch
        throw:X:Stack ->
            {error, {thrown, X, Stack}};
        error:X:Stack ->
            {error, {errored, X, Stack}};
        exit:X:Stack ->
            {error, {exited, X, Stack}}
    end.
