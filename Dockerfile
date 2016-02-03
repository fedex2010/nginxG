FROM nginx
EXPOSE 80 443

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY $APP_ENV/env.conf /etc/nginx/env/env.conf