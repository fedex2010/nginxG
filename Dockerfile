FROM garbarino/nginx-newrelic
EXPOSE 80 81

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY security /etc/nginx/security
COPY api /etc/nginx/api
COPY fe /etc/nginx/fe
COPY env.conf /etc/nginx/env.conf
COPY env.conf.ci /etc/nginx/env.conf.ci
COPY env.conf.staging /etc/nginx/env.conf.staging
COPY env.conf.prod /etc/nginx/env.conf.prod

COPY upstreams.conf /etc/nginx/
COPY upstreams.conf.ci /etc/nginx/
COPY upstreams.conf.staging /etc/nginx/
COPY upstreams.conf.prod /etc/nginx/

COPY scripts/env_gen.sh /etc/nginx/scripts/env_gen.sh
COPY scripts/startup.sh /etc/nginx/scripts/startup.sh
COPY resolvers.conf /etc/nginx/resolvers.conf
COPY nginx-nr-agent.ini /etc/nginx-nr-agent/nginx-nr-agent.ini
COPY nginx-nr-agent.ini.ci /etc/nginx-nr-agent/nginx-nr-agent.ini.ci
COPY nginx-nr-agent.ini.staging /etc/nginx-nr-agent/nginx-nr-agent.ini.staging
COPY nginx-nr-agent.ini.prod /etc/nginx-nr-agent/nginx-nr-agent.ini.prod


CMD /etc/nginx/scripts/startup.sh
