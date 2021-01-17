-module(rebar3_shine).

-export([init/1, do/1, format_error/1, extract_test_modules/1, extract_tests/1]).

-define(PROVIDER, shine).
-define(DEPS, [app_discovery]).

-include("src/shine_Test.hrl").
-include("src/shine_TestModule.hrl").

%% ===================================================================
%% Public API
%% ===================================================================
-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    Provider =
        providers:create([{name, ?PROVIDER},
                          {module, ?MODULE},
                          {bare, true},
                          {deps, ?DEPS},
                          {example, "rebar3 shine"},
                          {opts, []},
                          {short_desc, "A rebar plugin"},
                          {desc, "A rebar plugin"},
                          {profiles, [test]}]),
    {ok, rebar_state:add_provider(State, Provider)}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    {ok, State1} = rebar_prv_compile:do(State),
    code:add_pathsa(
        rebar_state:code_paths(State1, all_deps)),

    Paths = filelib:wildcard("gen/test/**/*.erl") ++ filelib:wildcard("test/**/*.erl"),
    Suite = extract_test_modules(Paths),

    provider_do(State1, fun(_) -> shine:run_suite(Suite) end),

    {ok, State1}.

provider_do(State, Fun) ->
    case code:ensure_loaded(rebar_gleam) of
        {module, rebar_gleam} ->
            rebar_gleam:provider_do(State, Fun);
        {error, _} ->
            Fun(State)
    end.

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).

extract_test_modules(Paths) ->
    lists:map(fun(Path) ->
                 ModuleName = filename:basename(Path, ".erl"),
                 Module = list_to_atom(ModuleName),
                 #test_module{name = ModuleName, tests = extract_tests(Module)}
              end,
              Paths).

extract_tests(Module) ->
    lists:filtermap(fun({Function, Arity}) ->
                       case is_test(Function, Arity) of
                           true -> {true, to_test(Module, Function, Arity)};
                           false -> false
                       end
                    end,
                    Module:module_info(exports)).

is_test(Name, 0) ->
    string:find(atom_to_list(Name), "_", trailing) =:= "_test";
is_test(_Name, _Arity) ->
    false.

to_test(Module, FunctionName, 0) ->
    Fun = fun() -> gleam_stdlib:rescue(fun() -> erlang:apply(Module, FunctionName, []) end)
          end,
    #test{module = atom_to_list(Module),
          name = atom_to_list(FunctionName),
          run = Fun}.
