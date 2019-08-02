FROM node
WORKDIR /sdk
COPY . .

# Set the locale
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

# Set the c9 core
RUN /sdk/scripts/install-sdk.sh
EXPOSE 8080

ENV C9_IP 0.0.0.0
ENV C9_PORT 8080
ENV WORKSPACE_DIR /root/
ENV USERNAME ""
ENV PASSWORD ""
ENTRYPOINT node server.js -l $C9_IP -p $C9_PORT -w $WORKSPACE_DIR -a $USERNAME:$PASSWORD --packed