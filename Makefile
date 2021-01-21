test: noop
	rebar3 eunit
	rebar3 format --verify
	gleam format --check src test

compile: noop
	gleam build

format: noop
	rebar3 format && gleam format

noop:
