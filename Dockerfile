FROM grafana/grafana:3.1.1
MAINTAINER Jimmi Dyson <jimmidyson@gmail.com>

ENTRYPOINT ["/run.sh"]

ENV GF_AUTH_ANONYMOUS_ENABLED true
ENV GF_DASHBOARDS_JSON_ENABLED true
ENV GF_DASHBOARDS_JSON_PATH /dashboards
ENV GF_LOG_MODE console

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN chmod 777 /var/lib/grafana /usr/share/grafana/
RUN chown grafana /var/lib/grafana
RUN chown grafana /usr/share/grafana/

#ADD curl_7.38.0-4+deb8u4_amd64.deb /curl_7.38.0-4+deb8u4_amd64.deb
#ADD libcurl3_7.38.0-4+deb8u4_amd64.deb /libcurl3_7.38.0-4+deb8u4_amd64.deb
#RUN dpkg -i /curl_7.38.0-4+deb8u4_amd64.deb /libcurl3_7.38.0-4+deb8u4_amd64.deb
#RUN apt-get update
#RUN apt-get -y --no-install-recommends install libfontconfig curl ca-certificates

ADD debian-packages /debian-packages
RUN dpkg -i /debian-packages/*.deb

ADD run.sh /run.sh
RUN chown grafana /run.sh
RUN chmod 777 /run.sh
ADD dashboards /dashboards
RUN chmod 777 /dashboards && chmod 666 /dashboards/*

USER grafana
