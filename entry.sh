#!/bin/bash
set -e

ln -s /root/.cargo $HOME/.cargo
ln -s /root/.rustup $HOME/.rustup

: ${GITHUB_WORKSPACE="./"}

cd $GITHUB_WORKSPACE
cd $2

cargo deb $1
