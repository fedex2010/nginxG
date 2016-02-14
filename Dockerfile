FROM nginx
EXPOSE 80 443

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY security /etc/nginx/security
COPY api /etc/nginx/api
COPY env.conf /etc/nginx/env/env.conf
COPY scripts/env_gen.sh /etc/nginx/scripts/env_gen.sh


CMD /etc/nginx/scripts/env_gen.sh; nginx -g 'daemon off;';