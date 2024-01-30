FROM registry.access.redhat.com/ubi9-minimal:latest

LABEL org.opencontainers.image.source="https://github.com/ctron/batteries-included"
LABEL org.opencontainers.image.description="A cloud side scripting container, batteries included."

ARG KUBECTL_VERSION="1.25.4"
ARG HTTPIE_VERSION='~=3.2'

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY bin/add-version.sh /usr/local/bin/add-version
COPY bin/arch.sh /usr/local/bin/arch
COPY bin/versions.sh /usr/local/bin/versions

RUN \
    PACKAGES="jq findutils pip bzip2 curl-minimal wget" && \
    microdnf -y install ${PACKAGES} && \
    \
    add-version jq "$(rpm -q jq)" "$(jq --version)" && \
    add-version find "$(rpm -q findutils)" "$(find --version)" && \
    add-version pip "$(rpm -q pip)" "$(pip --version)" && \
    add-version curl "$(rpm -q curl-minimal)" "$(curl --version)" && \
    add-version wget "$(rpm -q wget)" "$(wget --version)"


# add CentOS key
RUN \
    curl -sSL https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official -O \
    && gpg --quiet --with-fingerprint RPM-GPG-KEY-CentOS-Official \
    && rm RPM-GPG-KEY-CentOS-Official

# lrzsz
RUN \
    curl -sSL https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/lrzsz-0.12.20-55.el9.x86_64.rpm -o lrzsz.rpm \
    && rpm -Uvh lrzsz.rpm \
    && rm lrzsz.rpm \
    && add-version rz "$(rpm -q lrzsz)" "$(rz --version)"\
    && add-version sz "$(rpm -q lrzsz)" "$(sz --version)"

# kubectl
RUN \
    curl -sSL "https://dl.k8s.io/v${KUBECTL_VERSION}/bin/linux/$(arch -2)/kubectl" -o /usr/local/bin/kubectl && \
    chmod a+x /usr/local/bin/kubectl && \
    add-version kubectl "${KUBECTL_VERSION}" "$(kubectl version --short --client=true)"


# httpie
RUN \
    pip3 install httpie${HTTPIE_VERSION} && \
    add-version http "${HTTPIE_VERSION}" "$(http --version)"


RUN \
    versions

