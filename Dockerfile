FROM registry.access.redhat.com/ubi9-minimal:latest

LABEL org.opencontainers.image.source="https://github.com/ctron/batteries-included"
LABEL org.opencontainers.image.description="A cloud side scripting container, batteries included."

ARG KUBECTL_VERSION="1.25.4"
ARG HTTPIE_VERSION="3.2.1"

COPY bin/add-version.sh /usr/local/bin/add-version
COPY bin/arch.sh /usr/local/bin/arch
COPY bin/versions.sh /usr/local/bin/versions

RUN \
    PACKAGES="jq findutils pip" && \
    microdnf -y install ${PACKAGES} && \
    \
    add-version jq "$(rpm -q jq)" "$(jq --version)" && \
    add-version find "$(rpm -q findutils)" "$(find --version)"


# kubectl
RUN \
    curl -sSL "https://dl.k8s.io/v${KUBECTL_VERSION}/bin/linux/$(arch -2)/kubectl" -o /usr/local/bin/kubectl && \
    chmod a+x /usr/local/bin/kubectl && \
    add-version kubectl "${KUBECTL_VERSION}" "$(kubectl version --short --client=true)"


# httpie
RUN \
    pip3 install httpie && \
    add-version http "${HTTPIE_VERSION}" "$(http --version)"


RUN \
    versions

