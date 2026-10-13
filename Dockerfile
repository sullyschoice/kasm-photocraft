FROM kasmweb/core-ubuntu-noble:1.19.0-rolling-daily
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Leave empty to install the latest release, or pass e.g. --build-arg PHOTOCRAFT_VERSION=0.8.2
ARG PHOTOCRAFT_VERSION=""

COPY ./src/photocraft $INST_SCRIPTS/photocraft/
RUN PHOTOCRAFT_VERSION=${PHOTOCRAFT_VERSION} bash $INST_SCRIPTS/photocraft/install_photocraft.sh && rm -rf $INST_SCRIPTS/photocraft/

COPY ./src/photocraft/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
