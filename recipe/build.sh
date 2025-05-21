#!/usr/bin/env bash

set -euo pipefail

export OPENSSL_DIR=$PREFIX
export CARGO_PROFILE_RELEASE_STRIP=symbols
export CARGO_PROFILE_RELEASE_LTO=fat

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
cargo install --no-track --locked --root "$PREFIX" --path .

mkdir -p $PREFIX/share/bash-completion/completions
pixi-pack completion -s bash > $PREFIX/share/bash-completion/completions/pixi-pack
mkdir -p $PREFIX/share/zsh/site-functions
pixi-pack completion -s zsh > $PREFIX/share/zsh/site-functions/_pixi-pack
mkdir -p $PREFIX/share/fish/vendor_completions.d
pixi-pack completion -s fish > $PREFIX/share/fish/vendor_completions.d/pixi-pack.fish
