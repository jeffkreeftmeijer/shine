test: noop
	rebar3 eunit

compile: noop
	gleam build

format: noop
	rebar3 format && gleam format

noop:
