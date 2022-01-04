#!/bin/sh
set -ex

bin/ensure-dependencies

exec $*
