FROM hashicorp/terraform:1.14

USER root

RUN apk add --no-cache \
    bash \
    git \
    openssh-client \
    curl \
    python3 \
    py3-pip \
    aws-cli \
    ca-certificates \
    && update-ca-certificates

RUN terraform version \
    && git --version \
    && aws --version \
    && python3 --version

RUN mkdir -p /home/jenkins/agent \
    && chmod -R 777 /home/jenkins/agent

WORKDIR /home/jenkins/agent

ENTRYPOINT []

CMD ["sleep", "9999999"]