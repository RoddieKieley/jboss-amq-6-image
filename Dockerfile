# Copyright 2017 Red Hat
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ------------------------------------------------------------------------
#
# This is a Dockerfile for the jboss-amq-6/amq62:6.3.0 image.

FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift:1.1

# Environment variables
ENV JBOSS_IMAGE_NAME="jboss-amq-6/amq62" \
    JBOSS_IMAGE_VERSION="6.3.0" \
    JBOSS_PRODUCT="AMQ" \
    JBOSS_AMQ_VERSION="6.3.0.redhat_326" \
    PRODUCT_VERSION="6.3.0.redhat_326" \
    AMQ_HOME="/opt/amq" 

# Labels
LABEL name="$JBOSS_IMAGE_NAME" \
      version="$JBOSS_IMAGE_VERSION" \
      architecture="x86_64" \
      com.redhat.component="jboss-amq-6-amq63-docker" \
      description="Red Hat JBoss AMQ 6.3 container image" \
      summary="Red Hat JBoss AMQ 6.3 container image"


USER root

# Add all artifacts to the /tmp/artifacts
# directory
COPY \
    jboss-a-mq-6.3.0.redhat-326.zip \
    /tmp/artifacts/

# Add scripts used to configure the image
COPY scripts /tmp/scripts

# Custom scripts
USER root
RUN [ "bash", "-x", "/tmp/scripts/amq-install/install.sh" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/amq-chown/install.sh" ]


USER root
RUN rm -rf /tmp/scripts
USER root
RUN rm -rf /tmp/artifacts

USER 185


CMD ["/opt/amq/bin/activemq", "console"]
