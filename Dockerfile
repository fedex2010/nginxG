FROM nginx
EXPOSE 80 443


COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.conf.ci /etc/nginx/nginx.conf.ci
COPY nginx.conf.staging /etc/nginx/nginx.conf.staging
COPY nginx.conf.prod /etc/nginx/nginx.conf.prod
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY security /etc/nginx/security
COPY api /etc/nginx/api
COPY env.conf /etc/nginx/env/env.conf
COPY env_gen.sh /etc/nginx/env_gen.sh


CMD /etc/nginx/env_gen.sh; nginx -g 'daemon off;';