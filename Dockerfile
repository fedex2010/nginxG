FROM nginx
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
COPY scripts/env_gen.sh /etc/nginx/scripts/env_gen.sh
COPY resolvers.conf /etc/nginx/resolvers.conf


CMD /etc/nginx/scripts/env_gen.sh; nginx -g 'daemon off;';
