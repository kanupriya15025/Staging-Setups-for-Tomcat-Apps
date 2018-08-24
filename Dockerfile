FROM tomcat:8.0-jre8
MAINTAINER Kanupriya Batra <kanupriya15025@iiitd.ac.in>
RUN echo 'deb http://deb.debian.org/debian stretch main'; \
				echo 'deb http://security.debian.org stretch/updates main'; \
				echo 'deb http://deb.debian.org/debian stretch-updates main'; \
			 > /etc/apt/sources.list.d/stretch.list;
RUN apt-get update; \
    apt-get clean;
RUN apt-get install --assume-yes vim apt-transport-https
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
RUN apt-get update
RUN apt-get install --assume-yes --allow-unauthenticated filebeat
COPY filebeat.yml /etc/filebeat/filebeat.yml
COPY ./entrypoint.sh /opt/
RUN ["chmod", "+x", "/opt/entrypoint.sh"]
ENTRYPOINT ["/opt/entrypoint.sh"]
