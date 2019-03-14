FROM debian:stretch

# Set ansible config path
ENV ANSIBLE_CONFIG ./ansible.cfg

# Update ansible & other tools
RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y \
    python \
    python-yaml \
    python-mysqldb \
    python-crypto \
    mysql-client \
    sudo \
    curl \
    gcc \
    python-pip \
    python-dev \
    libffi-dev \
    libssl-dev \
    curl \
    bash \
    nano \
    gettext-base

RUN apt-get -y --purge remove python-cffi
RUN pip install --upgrade \
    cffi \
    pywinrm \
    ansible==2.7.4 \
    openshift

# Clear APK cache
RUN rm -rf /var/cache/apk/*

LABEL version="1.0.0"
LABEL com.github.actions.name="GitHub Action for Ansible"
LABEL com.github.actions.description="Wraps Ansible CLI to enable common commands."
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="purple"
# Bring git back so we can install roles with Ansible Galaxy
RUN apt-get update -y && apt-get install -y git-core

COPY . /
RUN chmod 775 entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]