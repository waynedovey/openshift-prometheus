FROM grafana/grafana:2.6.0
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

ADD run.sh /run.sh
ADD dashboards /dashboards
RUN chmod 777 /dashboards && chmod 666 /dashboards/*

USER grafana
