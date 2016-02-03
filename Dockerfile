FROM danday74/nginx-lua
EXPOSE 80
EXPOSE 443


COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
