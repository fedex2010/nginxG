FROM nginx
EXPOSE 80 443


COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY security /etc/nginx/security
COPY api /etc/nginx/api
COPY env.conf /etc/nginx/env/env.conf
COPY env.conf.ci /etc/nginx/env.conf.ci
COPY env.conf.staging /etc/nginx/env.conf.staging
COPY env.conf.prod /etc/nginx/env.conf.prod
COPY env_gen.sh /etc/nginx/env_gen.sh


CMD /etc/nginx/env_gen.sh; nginx -g 'daemon off;';