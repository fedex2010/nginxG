FROM danday74/nginx-lua
EXPOSE 80 443

COPY nginx.conf /nginx/conf/nginx.conf
COPY conf.d /nginx/conf/conf.d
COPY includes /nginx/conf/includes
