#!/usr/bin/env bash
#
# =======================================
# AUTHOR        : Claudio Prato @ Team EA
# CREATE DATE   : 2021/11/18
# PURPOSE       : build distroless image
# SPECIAL NOTES : UBI8 micro based
# =======================================
#
# set -o errexit
# set -o pipefail
# set -o nounset
# set -o xtrace

# Set magic variables for current file & dir
# __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# __file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
# __base="$(basename ${__file} .sh)"
# __root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app

# Labels
VERSION=1.1.0
AWS_TARGET_BIN_DIR=/usr/local/bin

### IMAGE MOUNT
microcontainer=$(buildah from registry.access.redhat.com/ubi8/ubi-micro)
micromount=$(buildah mount $microcontainer)

### DEPENDECIES SETUP
echo "===> Installing OS Utility";
yum install \
    --installroot $micromount \
    --releasever 8 \
    --setopt install_weak_deps=false \
    --setopt tsflags=nodocs \
    less gawk groff-base -y

### PACKAGE CLEAN
yum clean all \
    --installroot $micromount
rm -rf $micromount/var/cache $micromount/var/log/yum.*

### SETENV
# mkdir $micromount/{.docker,.aws} && touch $micromount/.docker/config.json $micromount/.aws/config;
# chmod 777 $micromount/.docker/config.json $micromount/.aws/config;

### SETUP: awscli2
echo "===> Installing the aws-cli";
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -O -L -J
unzip awscli-exe-linux-x86_64.zip && ./aws/install --bin-dir $micromount${AWS_TARGET_BIN_DIR} --install-dir $micromount/usr/local/aws-cli
# aws workaround to install on distroless
src_link_current=$(basename $micromount/usr/local/aws-cli/v?/?.*)
rm -f $micromount/usr/local/aws-cli/v?/current
pushd $micromount/usr/local/aws-cli/v? && ln -sf $src_link_current current; popd
src_link=$(echo $micromount/usr/local/aws-cli/v2/current/bin| awk -F merged '{ print $2 }')
ln -sf $src_link/aws_completer $micromount${AWS_TARGET_BIN_DIR}/aws_completer
ln -sf $src_link/aws $micromount${AWS_TARGET_BIN_DIR}/aws
rm -rf awscli-exe-linux-x86_64.zip aws

### SETUP: Kubectl, OC client
curl -L https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz | tar -xzf -
mv openshift-origin-client*/oc openshift-origin-client*/kubectl $micromount${AWS_TARGET_BIN_DIR}/
rm -rf openshift-origin-client*

### IMAGE COMMIT
buildah umount $microcontainer
buildah commit $microcontainer cprato79/kubectl:$VERSION
