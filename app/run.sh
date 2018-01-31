#!/bin/sh

cd /home/runner/artifacts

#Generate and inject config.json into dist
mkdir -p .next/src/dist/config
java -cp /home/runner/tools/confy-assembly-3.0.jar confy.app.ConfigurationApp -i conf/combined.conf > .next/src/dist/config/config.json

./node_modules/.bin/next start