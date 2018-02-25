#
# Next.js 4.2 Runner Image
# Docker image with tools and scripts installed to support the running of a Next.js 4.2 web app
# Expects build artifacts (node_modules and .next directories) mounted at /home/runner/artifacts
#

FROM node:9.4.0-alpine
MAINTAINER Agile Digital <info@agiledigital.com.au>
LABEL Description="Docker image with libraries and tools as required to support the running of a Next.js 4.2 web app" Vendor="Agile Digital" Version="0.1"

ENV HOME /home/runner
WORKDIR /home/runner

RUN apk add --update --no-cache openjdk8-jre

RUN addgroup -S -g 10000 runner
RUN adduser -S -u 10000 -h $HOME -G runner runner

COPY app /home/runner/app
COPY tools /home/runner/tools
RUN chmod +x /home/runner/app/run.sh

EXPOSE 3000

# We need to support Openshift's random userid's
# Openshift leaves the group as root. Exploit this to ensure we can always write to them
# Ensure we are in the the passwd file
RUN chmod g+w /etc/passwd
RUN chgrp -Rf root /home/runner && chmod -Rf g+w /home/runner
ENV RUNNER_USER runner

USER runner

ENTRYPOINT [ "/home/runner/app/run.sh" ]
