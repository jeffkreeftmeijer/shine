# ✨ Shine

A work-in-progress test runner for Gleam and Erlang.

## Installation

Add Shine to `project_plugins` in your project's `rebar.config`:

``` erlang
% rebar.config
{project_plugins, [rebar_gleam, shine]}.
```

Shine isn't available on Hex just yet, so you'll have to check it out in `_checkouts`:

    $ git clone git@github.com:jeffkreeftmeijer/shine.git _checkouts/shine

## Usage

    $ rebar3 shine

Find any differences between running EUnit and Shine in your project? Please [open an issue](https://github.com/jeffkreeftmeijer/shine/issues/new).
