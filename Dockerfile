FROM python:2.7-alpine 
LABEL maintainer bitrox <proxy@bitrox.io>

# Set environment variables. 
#ENV TERM=xterm-color 
ENV SHELL=/bin/bash

RUN \
	mkdir /mosquitto && \
	mkdir /mosquitto/log && \
	mkdir /mosquitto/conf && \
	apk update && \
	apk upgrade && \
	apk add \
		bash \
		coreutils \
		mosquitto \
		mosquitto-clients && \
	rm -f /var/cache/apk/* 
	#pip install --upgrade pip 
	#&& \
	#pip install pyRFC3339 configobj ConfigArgParse
	
COPY run.sh /run.sh
COPY restart.sh /restart.sh

RUN \
	chmod +x /run.sh && \
	chmod +x /restart.sh
	
EXPOSE 1883 
EXPOSE 8883 
EXPOSE 80 

# This will run any scripts found in /scripts/*.sh # then start Apache 
CMD ["/bin/bash","-c","/run.sh"]
