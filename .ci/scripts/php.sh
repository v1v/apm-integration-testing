#!/bin/bash -e
# for details about how it works see https://github.com/elastic/apm-integration-testing#continuous-integration

srcdir=$(dirname "$0")
test -z "$srcdir" && srcdir=.
# shellcheck disable=SC1090
. "${srcdir}/common.sh"

DEFAULT_COMPOSE_ARGS="${ELASTIC_STACK_VERSION} ${BUILD_OPTS} \
  --no-apm-server-dashboards \
  --no-apm-server-self-instrument \
  --with-agent-php-apache \
  --apm-server-agent-config-poll=1s \
  --force-build \
  --no-xpack-secure"
export COMPOSE_ARGS=${COMPOSE_ARGS:-${DEFAULT_COMPOSE_ARGS}}
runTests env-agent-php docker-test-agent-php
