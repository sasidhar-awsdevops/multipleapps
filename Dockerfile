# Stage 1
FROM ruby:2.7.1-alpine3.12 As builder
RUN apk add --no-cache bash
RUN /bin/sh
RUN apk update && apk add --virtual build-dependencies build-base
RUN gem install bundler

# RUN bundle install
RUN apk add --no-cache curl-dev \
  && apk add --no-cache --virtual .builddeps build-base \
  && gem install badge -v 0.8.7 \
  && apk del .builddeps
RUN gem install compass  
RUN gem install sass
RUN apk add --update nodejs npm
RUN npm install -g bower 
RUN npm install -g grunt-cli 
RUN npm install grunt-serve
RUN npm install pm2 -

# Stage 2 [working code]
# use the base image to import the application directories
#FROM builder as cmshare
RUN mkdir -p /app
COPY package.json /app
WORKDIR /app
RUN npm install
COPY . .
RUN npm install -g @angular/cli
RUN ng build --prod --project="gettingStarted"
RUN ng build --prod --project="exampleApp"
CMD ng serve --project="gettingStarted" --host 0.0.0.0 --port 4201 & ng serve --project="exampleApp" --host 0.0.0.0 --port 4202
#CMD ng serve --project="exampleApp" --host 0.0.0.0 --port 4202
#ENTRYPOINT ng serve --project="exampleApp" --host 0.0.0.0 --port 4202

# Stage 2 [testing dist folder copy alone]
# use the base image to import the application directories
#FROM builder as cmshare
#RUN mkdir -p /app
#COPY package.json /app
#WORKDIR /app
#RUN npm install
#COPY /dist .
#RUN npm install -g @angular/cli
#RUN ng build --prod --project="gettingStarted"
#RUN ng build --prod --project="exampleApp"
#CMD ng serve --project="gettingStarted" --host 0.0.0.0 --port 4201 & ng serve --project="exampleApp" --host 0.0.0.0 --port 4202
#CMD ng serve --project="exampleApp" --host 0.0.0.0 --port 4202
#ENTRYPOINT ng serve --project="exampleApp" --host 0.0.0.0 --port 4202

