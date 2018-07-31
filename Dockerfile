FROM tomcat:8.0-jre8
MAINTAINER Kanupriya Batra <kanupriya.b@media.net>
RUN echo "deb http://repo.srv.media.net testing sysops" | tee /etc/apt/sources.list.d/skenzo.list; \
    apt-get update; \
    apt-get install --force-yes --allow-unauthenticated libjudydebian1 judytree; \
    apt-get clean;
RUN apt-get install --assume-yes vim apt-transport-https
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
RUN apt-get update
RUN apt-get install --assume-yes --allow-unauthenticated filebeat
COPY filebeat.yml /etc/filebeat/filebeat.yml
COPY ./entrypoint.sh /opt/
RUN ["chmod", "+x", "/opt/entrypoint.sh"]
ENTRYPOINT ["/opt/entrypoint.sh"]
