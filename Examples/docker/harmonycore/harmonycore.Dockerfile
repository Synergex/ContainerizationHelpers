FROM jeffkube.azurecr.io/testk3s/synergy1211net6:latest
#ARG LM_HOST
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
SHELL ["/bin/bash", "-c"]

# Become the "admin" user
USER admin:admin

# Create a folder to put the Harmony Core files in
RUN mkdir /home/admin/service
RUN chown admin:admin /home/admin/service
RUN chmod 775 /home/admin/service

COPY --chown=admin:admin container_files/container_start /home/admin/container_start

# Copy and unzip the Harmony Core service files
COPY --chown=admin:admin container_files/HarmonyCoreService-linux.zip /home/admin/HarmonyCoreService-linux.zip
RUN unzip /home/admin/HarmonyCoreService-linux.zip -d /home/admin/service
RUN rm -f /home/admin/HarmonyCoreService-linux.zip
RUN chmod 775 /home/admin/service/*

# Open the ports that the Harmony Core service uses
EXPOSE 8085 8086

# Run the startup script
CMD ["sh", "-c", "/home/admin/container_start $LM_HOST"]
