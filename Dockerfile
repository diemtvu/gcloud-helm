FROM google/cloud-sdk:alpine

# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v2.14.0"

# Note: Latest version of the provider may be found at:
# https://github.com/terraform-providers/terraform-provider-helm/releases
ENV HELM_PROVIDER_VERSION="0.6.0"

RUN apk add wget --no-cache --virtual /tmp/.build-deps


# The helm provider binary was compiled with glibc and on Alpine that is not 
# installed by default. Since the musl and glibc so are compatible we need to create this symlink. 
# RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

RUN wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm
