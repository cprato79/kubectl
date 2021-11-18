FROM registry.access.redhat.com/ubi8/ubi

## ::: Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
## ::: the LABEL directive is not affect the image size
LABEL name="kubectl" \
      version="1.0.0" \
      authors="cprato79@gmail.com" \
      description="Utility Image aimed for managing the following resources: aws, kubernetes and openshift cluster."

ENV CONTAINER=docker

WORKDIR /workspace

## ::: utility and dependecies packages
RUN set -eux; \
    echo "===> Installing OS Utility"; \
    # INSTALL_PKGS="container-selinux git python3-pip unzip"; \
    INSTALL_PKGS="unzip groff-base"; \
    yum -y install --setopt=tsflags=nodocs ${INSTALL_PKGS}; \
    rpm -q ${INSTALL_PKGS}; \
    # yum -y clean all --enablerepo="*"; \
    rm -rf /var/cache /var/log/dnf* /var/log/yum.*; \
    mkdir /.docker /.aws && touch /.docker/config.json /.aws/config; \
    echo "===> Installing the aws-cli"; \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    unzip awscliv2.zip && ./aws/install && rm -rf awscliv2.zip; \
    # pip3 install --upgrade awscli; \
    chmod 777 /.docker/config.json /.aws/config; \
    echo "===> Installing both the Kubectl and OC client"; \
    curl -L# https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz -o openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz; \
      tar xvf openshift-origin-client-tools*.tar.gz; \
      cd openshift-origin-client*/; \
      mv oc kubectl /usr/local/bin/; \
      rm -rf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz;

# USER 1001

VOLUME ["/workspace"]

# ENTRYPOINT ["/bin/bash"]
