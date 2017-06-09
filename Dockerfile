# appagile-nginx-rhel7
FROM registry.access.redhat.com/rhscl/nginx-18-rhel7

MAINTAINER AppAgile Team <appagiles@t-systems.com>


EXPOSE 8080
EXPOSE 8443

USER root

ENV APPAGILE_NIGINX18_STI_RHEL7_VERSION=1

# Add some basic helpful packages
RUN yum -y update \
         && yum -y install less net-tools procps rsync perl bind-utils telnet gettext\
         && yum clean all 

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./.s2i/bin/ $STI_SCRIPTS_PATH

RUN chmod -R a+rwx /etc/opt/rh/rh-nginx18/nginx/ 

RUN chown -R 1001:1001 /opt/app-root

USER 1001

CMD $STI_SCRIPTS_PATH/usage

