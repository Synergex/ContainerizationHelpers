FROM jeffkube.azurecr.io/testk3s/synergy1211:latest
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
SHELL ["/bin/bash", "-c"]

RUN export DEBIAN_FRONTEND=noninteractive

COPY --chown=admin:admin container_files/admin_login_script /home/admin/.bash_login
COPY --chown=admin:admin container_files/hello_world.dbl /home/admin/hello_world.dbl
RUN chmod +x /home/admin/container_start
RUN source /synergyde/setsde && /synergyde/lm/synd && cd /home/admin && dbl -o hello_world.dbo hello_world.dbl && dblink -o hello_world.dbr hello_world.dbo 

# Start the SSH server and open port 22
RUN service ssh start
EXPOSE 22

# Run the startup script
CMD ["sh", "-c", "/home/admin/container_start $LM_HOST"]

