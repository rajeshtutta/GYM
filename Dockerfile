FROM nginx:alpine

# remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# copy project files
COPY . /usr/share/nginx/html

# expose web port
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
