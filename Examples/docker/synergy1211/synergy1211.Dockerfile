FROM steveives/ubuntu2204:latest
ARG GIT_TOKEN
ARG LM_HOST
ENV LM_HOST=$LM_HOST
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
SHELL ["/bin/bash", "-c"]

ENV TERM=vt100

# Install additional packages 
#ARG DEBIAN_FRONTEND=noninteractive
#RUN apt-get update
#RUN apt-get install -y package1 package2

# Download the Synergy installation
RUN wget --quiet https://s3.amazonaws.com/media.synergex.com/prod/428SDE1211-3278.a -O installer.a

# Download the Synergy automated install script
RUN wget --quiet https://raw.githubusercontent.com/Synergex/ContainerizationHelpers/main/InstallerScripts/12.1.1-3278/installer.auto

# Install Synergy
RUN umask 0
RUN cpio -icvBdum < installer.a
RUN chmod a+x ./installer.auto
RUN chmod a+x ./install.sde
RUN ./installer.auto -n $LM_HOST

# Update files in the admin account
COPY --chown=admin:admin container_files/admin_login_script /home/admin/.bash_login
COPY --chown=admin:admin container_files/container_start /home/admin/container_start
RUN chmod +x /home/admin/container_start

# Start the SSH server and open port 22
RUN service ssh start
EXPOSE 22

# Run the startup script
CMD ["sh", "-c", "/home/admin/container_start $LM_HOST"]

