FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client less vim locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
  gem install bundler && \
  gem install foreman

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn
ENV app /app
RUN mkdir $app
WORKDIR $app

ADD . $app
#RUN bundle install
#RUN yarn install

# # Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
