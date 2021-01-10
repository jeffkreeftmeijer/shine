-module(rebar3_shine).

-export([init/1, do/1, format_error/1, extract_tests/1]).

-define(PROVIDER, shine).
-define(DEPS, [app_discovery]).

%% ===================================================================
%% Public API
%% ===================================================================
-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    Provider =
        providers:create([{name, ?PROVIDER},            % The 'user friendly' name of the task
                          {module, ?MODULE},            % The module implementation of the task
                          {bare,
                           true},                       % The task can be run by the user, always true
                          {deps, ?DEPS},                % The list of dependencies
                          {example, "rebar3 shine"},    % How to use the plugin
                          {opts, []},                   % list of options understood by the plugin
                          {short_desc, "A rebar plugin"},
                          {desc, "A rebar plugin"}]),
    {ok, rebar_state:add_provider(State, Provider)}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    rebar_gleam:provider_do(State,
                            fun(State1) ->
                               compile:file("gen/test/shine_test"),
                               Pass = fun shine_test:passing/0,
                               Fail = fun shine_test:failing/0,

                               shine:run_suite([{"shine_test", [Pass, Fail]}]),
                               {ok, State1}
                            end).

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).

extract_tests(Module) ->
  Exports = Module:module_info(exports),
  TestNames = lists:filter(fun is_test/1, Exports),

  lists:map(fun ({Function, Arity}) ->
    to_fun(Module, Function, Arity)
  end, TestNames).

is_test({Name, 0}) ->
  string:find(atom_to_list(Name), "_", trailing) =:= "_test";
is_test({Name, Arity}) -> false.

to_fun(Module, Function, 0) ->
  fun() ->
      erlang:apply(Module, Function, [])
  end.
