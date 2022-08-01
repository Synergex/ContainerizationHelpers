FROM jeffkube.azurecr.io/testk3s/synergy1211:latest

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
SHELL ["/bin/bash", "-c"]

RUN export DEBIAN_FRONTEND=noninteractive

# Install the Microsoft package feed
RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get install -y apt-transport-https
RUN apt-get update

# Install packages
RUN apt-get install -y --no-install-recommends dotnet-sdk-6.0 libnss3-tools
#aspnetcore-runtime-6.0
 
# Cleanup
RUN rm -rf /var/lib/apt/lists/*

# Run the startup script
CMD ["sh", "-c", "/home/admin/container_start $LM_HOST"]
