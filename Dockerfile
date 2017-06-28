FROM grafana/grafana:4.2.0
MAINTAINER MB

ENTRYPOINT ["/run.sh"]

ENV GF_AUTH_ANONYMOUS_ENABLED true
ENV GF_DASHBOARDS_JSON_ENABLED false
ENV GF_DASHBOARDS_JSON_PATH /dashboards
ENV GF_LOG_MODE console

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN chmod 777 /var/lib/grafana /usr/share/grafana/
RUN chown grafana /var/lib/grafana
RUN chown grafana /usr/share/grafana/

ADD debian-packages /debian-packages
RUN dpkg -i /debian-packages/*.deb

RUN apt-get update
RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_7.x |  bash -
RUN apt-get install nodejs -y
RUN npm install -g wizzy

ADD run.sh /run.sh
RUN chown grafana /run.sh
RUN chmod 777 /run.sh
ADD dashboards /dashboards
RUN mkdir /conf
RUN chmod 777 /dashboards && chmod 666 /dashboards/* && chmod 777 /conf

ADD plugins/savantly-heatmap-panel /usr/share/grafana/public/app/plugins/panel/savantly-heatmap-panel
RUN chmod -R 777 /usr/share/grafana/public/app/plugins/panel/savantly-heatmap-panel

USER grafana
