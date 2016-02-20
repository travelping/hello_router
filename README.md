UniMux [![Build Status](https://travis-ci.org/carosio/unimux.svg)](https://travis-ci.org/carosio/unimux) [![Coverage Status](https://coveralls.io/repos/carosio/unimux/badge.svg?branch=master&service=github)](https://coveralls.io/github/carosio/unimux?branch=master)
======


UniMux applciation for routing [hello](https://github.com/travelping/hello)-based requests.

Minimal requirements are:

* erlang >= 17 (better 17.5)
* elixir >= 1.0 (1.1.0-dev)
* Apple Bonjour or a compatible API such as Avahi with it's compatibility layer along with the appropriate development files:
  * OS X - bundled
  * Windows - Bonjour SDK
  * BSD/Linux - search for Avahi in your operating systems software manager

If you install erlang on Ubuntu, install aditionally:

* erlang-parsetools
* erlang-eunit

Build an application:

    $> mix do deps.get, compile

Start an interactive shell with application:

    $> iex -S mix

Dev configuration is placed on `config/config.exs`

Release configuration is placed here: `unimux.conf`, but should not changed manuelly, instead change the schema: `unimux.schema.exs` and regenerate the configuration with:

    $> mix conform.configure

Build an test release locally:

    $> MIX_ENV=prod mix release

See more information about releases here: [exrm](https://github.com/bitwalker/exrm) and [relx](https://github.com/erlware/relx)

Build release on builder, which does download dependencies for you, use release enviroment, which overwrites the pathes to `deps/<app>`

    $> MIX_ENV=release mix release

Building the documentation:

    $> mix docs

## Metrics

UniMux collects the following metrics via exometer_core and reports it to the each registered reporters: 

| Exometer ID                         | Type    | Data Point | Report Time |
|-------------------------------------|---------|------------|-------------|
| [:unimux, Prefix, :resolved]        | counter |    value   |   1000      |
| [:unimux, :not_resolved]            | counter |    value   |   1000      |
