# Pull base image.
FROM dockerfile/ubuntu

# aptitude update and install
RUN apt-get update
RUN apt-get -y install python
RUN	apt-get clean
RUN	rm -rf /var/lib/apt/lists/*

WORKDIR /app

# copy over start script and page
COPY start.sh start.sh
COPY index.html index.html

# start ghost
CMD ["bash", "/app/start.sh"]

# listen on this port
EXPOSE 8000

