# ✨ Shine

A work-in-progress test runner for Gleam and Erlang.

![Shine Logo](./shine-github.svg)

## Installation

Add Shine to `project_plugins` in your project's `rebar.config`. Shine is
currently released as 0.1.0-beta.1, which is a prerelease, so make sure to
allow installing prerelease versions through rebar3's `deps_allow_prerelease`
configuration:

``` erlang
% rebar.config
{deps_allow_prerelease, true}.

{project_plugins, [shine]}.
```

Or, to install Shine from its git repository:

``` erlang
% rebar.config
{project_plugins, [{shine, {git, "https://github.com/jeffkreeftmeijer/shine.git", {branch, "main"}}}]}.
```

## Usage

    $ rebar3 shine

Find any differences between running EUnit and Shine in your project? Please [open an issue](https://github.com/jeffkreeftmeijer/shine/issues/new).

## Troubleshooting

Due to https://github.com/gleam-lang/otp/issues/21, including Shine as a `project_plugin` might break compilation:

    $ rebar3 shine
    ===> Fetching shine (from {git,"https://github.com/jeffkreeftmeijer/shine.git",
                     {branch,"main"}})
    ===> Fetching gleam_otp v0.1.4
    ===> Fetching gleam_stdlib v0.12.0
    ===> Skipping gleam_stdlib v0.13.0 as an app of the same name has already been fetched
    ===> Analyzing applications...
    ===> Compiling gleam_otp
    ===> Compiling _build/default/plugins/gleam_otp/src/gleam_otp_external.erl failed
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:14: can't find include file "gen/src/gleam@otp@process_Sender.hrl"
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:15: can't find include file "gen/src/gleam@otp@process_Exit.hrl"
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:16: can't find include file "gen/src/gleam@otp@process_PortDown.hrl"
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:17: can't find include file "gen/src/gleam@otp@process_ProcessDown.hrl"
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:18: can't find include file "gen/src/gleam@otp@process_StatusInfo.hrl"

    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:119: record process_down undefined
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:122: record port_down undefined
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:125: record exit undefined
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:194: record sender undefined
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:207: record status_info undefined
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:210: variable 'Debug' is unbound
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:210: variable 'Mode' is unbound
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:210: variable 'Parent' is unbound
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:212: variable 'Mode' is unbound
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:212: variable 'Parent' is unbound
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:212: variable 'State' is unbound
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:214: variable 'Mod' is unbound

    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:118: Warning: variable 'Pid' is unused
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:118: Warning: variable 'Reason' is unused
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:121: Warning: variable 'Port' is unused
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:121: Warning: variable 'Reason' is unused
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:124: Warning: variable 'Pid' is unused
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:124: Warning: variable 'Reason' is unused
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:192: Warning: variable 'Pid' is unused
    _build/default/plugins/gleam_otp/src/gleam_otp_external.erl:193: Warning: variable 'Prepare' is unused

    ===> Errors loading plugin {shine,
                                       {git,
                                        "https://github.com/jeffkreeftmeijer/shine.git",
                                        {branch,"main"}}}. Run rebar3 with DEBUG=1 set to see errors.
    ===> Command shine not found

To work around this, copy
https://github.com/gleam-lang/otp/blob/main/gleam.toml into
`_build/default/plugins/gleam_otp`, then manually compile gleam_otp before
running `rebar3 shine`:

    $ (cd _build/default/plugins/gleam_otp; \
      curl https://raw.githubusercontent.com/gleam-lang/otp/main/gleam.toml -o gleam.toml; \
      rebar3 compile)
    $ rebar3 shine
