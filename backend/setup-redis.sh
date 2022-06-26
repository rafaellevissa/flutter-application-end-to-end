#!/bin/bash

docker run -v redis:/data -p 6379:6379 -e REDIS_PASSWORD=123Change@ --name redis -d --restart always redis /bin/sh -c 'redis-server --requirepass ${REDIS_PASSWORD}'