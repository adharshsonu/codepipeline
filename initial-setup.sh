rvm install "ruby-2.6.7"

gem install bundler:2.2.21

bundle install

rails db:create db:migrate

rails db:seed

rails s