FROM ruby:3.4.4

WORKDIR /app

RUN apt-get update -qq \
  && apt-get install -y build-essential pkg-config sqlite3 libsqlite3-dev \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
