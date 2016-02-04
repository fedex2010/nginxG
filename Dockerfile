FROM nginx
EXPOSE 80 443


COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY env.conf /etc/nginx/env/env.conf
CMD sed -i "s/epi_ui_dns_placeholder/$EPI_UI_DNS/g" "/etc/nginx/env/env.conf"; sed -i "s/epi_api_dns_placeholder/$EPI_API_DNS/g" "/etc/nginx/env/env.conf"