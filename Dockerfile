# logstash 7.6.0
FROM elastic/logstash@sha256:4eece90ef86ecd402280a9b5bf192c203f5cc6b31646a5ad940ec29a925ccf10

# setting shell
SHELL ["/bin/bash", "-c"]

# setting vm.max 
#RUN echo "vm.max_map_count=262144" >> /etc/sysctl.conf

# setting ENV 
ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/logstash/bin:$PATH

# setting workdir 
WORKDIR /usr/share/logstash

# copy mysql-connector
COPY config/mysql-connector-java-8.0.18.jar logstash-core/lib/jars/
COPY config/postgresql-42.2.14.jar logstash-core/lib/jars/

# copy config files
COPY config/logstash.yml config/logstash.yml
COPY config/pipelines.yml config/pipelines.yml

# setting pipeline
RUN rm -f pipeline/logstash.conf
COPY pipeline/ pipeline/

# install plugins
RUN bin/logstash-plugin install logstash-input-mongodb
