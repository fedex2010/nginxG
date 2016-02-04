FROM nginx
EXPOSE 80 443


COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY env.conf /etc/nginx/env/env.conf
COPY env_gen.sh /etc/nginx/env_gen.sh
CMD ./env_gen.sh; nginx 