FROM ruby:2.7

ENV RAILS_ENV=production
ENV NODE_ENV=production

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs postgresql-client \
    && rm -rf /var/lib/apt/lists/
RUN npm install -g yarn

WORKDIR /app

COPY Gemfile* ./
RUN bundle install
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --check-files

COPY . ./

RUN bundle exec rake webpacker:compile
RUN bundle exec rake assets:precompile

EXPOSE 3000