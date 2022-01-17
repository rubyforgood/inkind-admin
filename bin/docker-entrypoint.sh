#!/bin/sh
set -e

bin/ensure-dependencies

exec $*
