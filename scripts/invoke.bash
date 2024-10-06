#!/usr/bin/env bash
set -e

# ! The -d argument must be a Cloudevent which can be easily built here: https://build.cloudevents.gdn/
curl "http://localhost:9000/2015-03-31/functions/function/invocations" \
	-H "Content-Type: application/json" \
	-XPOST \
	-v \
	-d '{"id":"_M-213tYASTcB9zgaF5fz","source":"build.cloudevents.gdn","type":"cmd.placeholder.v0","specversion":"1.0","time":"2024-10-06T22:28:14.431Z","data":"{\"name\":\"Erik Ekberg\"}","datacontenttype":"application/json","originactor":"user:admin#id=1234","originid":"_M-213tYASTcB9zgaF5fz","originsource":"build.cloudevents.gdn","origintime":"2024-10-06T22:28:14.431Z","origintype":"cmd.placeholder.v0","wschannelid":"my-private-channel-name"}'
