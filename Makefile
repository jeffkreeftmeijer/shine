test: noop
	rebar3 eunit
	rebar3 shine
	rebar3 format --verify
	gleam format --check src test

bootstrap: noop
	rebar3 get-deps
	curl https://raw.githubusercontent.com/gleam-lang/otp/main/gleam.toml -o _build/default/plugins/gleam_otp/gleam.toml
	cd _build/default/plugins/gleam_otp/ && rebar3 compile

compile: noop
	gleam build

format: noop
	rebar3 format && gleam format

clean:
	rm -rf _build

noop:
