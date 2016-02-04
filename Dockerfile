FROM nginx
EXPOSE 80 443

RUN eval $(sudo ruby -e 'require "json"; container_config = JSON.parse(File.read("/opt/elasticbeanstalk/deploy/configuration/containerconfiguration")); raw_vars = container_config["optionsettings"]["aws:elasticbeanstalk:application:environment"]; envs = ""; raw_vars.each do |raw_var| envs << "export #{raw_var};\n" end; print envs;')

RUN echo $APP_ENV
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
COPY includes /etc/nginx/includes
COPY $APP_ENV/env.conf /etc/nginx/env/env.conf