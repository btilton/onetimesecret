FROM ruby:alpine

WORKDIR /onetime

COPY . /onetime

RUN apk update && apk add gcc g++ make

RUN mkdir /etc/onetime /var/log/onetime /var/run/onetime /var/lib/onetime

RUN gem install bundler -v '~>1'

RUN bundle install --frozen --deployment --without=dev

RUN bin/ots init

RUN cp -R etc/* /etc/onetime/

EXPOSE 8080

# Run this Dockerfile like
#  $ sudo docker build --tag=onetimesecret .
#  $ sudo docker run -d -p 8080:8080 onetimesecret
# Unless you know better I guess
CMD bundle exec thin -e dev -R config.ru -p 8080 start
