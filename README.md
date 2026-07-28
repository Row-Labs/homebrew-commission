# Commission — Homebrew tap

```sh
brew install Row-Labs/commission/commission
commission login
```

`Formula/commission.rb` is written by Commission's release workflow on each
tag — do not edit it by hand; the next release will overwrite it.

## Why a tap rather than homebrew-core

Commission is proprietary and its source is private. homebrew-core does not
accept proprietary formulae, and a build-from-source formula is impossible
without published source. So the formula installs a prebuilt binary from
`commission.sh`, verified by SHA-256.

The binaries are public because they are inert without a licence — Commission
checks one on the machine, at runtime, from the first command. Nothing in this
repository is source, and nothing here grants a licence.

<https://commission.sh>
