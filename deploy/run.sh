set -v
set -e

docker run -it --rm --name nginx \
	-v /home/rszj/lijf/multimodal/www/nginx.h5.conf:/etc/nginx/conf.d/h5.conf  \
	-v /home/rszj/lijf/multimodal/www/h5:/usr/share/nginx/htmlh5:ro  \
	-p 8080:80  \
	nginx:1.25.3-alpine3.18-slim  
