#!/usr/bin/env bash
set -e

curl \
	-XPOST \
	"http://localhost:9000/2015-03-31/functions/function/invocations" \
	-d '{"payload":"hello world!"}'
