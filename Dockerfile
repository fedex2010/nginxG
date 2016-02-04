FROM nginx
EXPOSE 80 443


COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY env.conf /etc/nginx/env/env.conf
COPY env_gen.sh /etc/nginx/env_gen.sh

RUN apt-get -y update; apt-get -y install nginx-nr-agent
COPY nginx-nr-agent.ini /etc/nginx-nr-agent/nginx-nr-agent.ini

CMD /etc/nginx/env_gen.sh; nginx -g 'daemon off;'; service nginx-nr-agent start