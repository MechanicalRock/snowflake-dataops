FROM "flyway/flyway"

USER root
RUN apt-get update && apt-get install -y --no-install-recommends  curl unixodbc jq
RUN apt-get install python3-pip -y --no-install-recommends && apt-get install -y python3-setuptools
RUN pip3 install awscli

