source 'https://rubygems.org'

gem 'emeals'
gem 'pg'
gem 'zurb-foundation', '4.2.3'
gem 'virtus'
gem 'tire'
gem 'haml'
gem 'will_paginate', '~> 3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
gem 'debugger', group: [:development, :test]

group :development do
  gem 'guard-rspec'
end

group :test do
  gem 'capybara'
  gem 'fuubar'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-mocks', '~> 2.14.0.rc1'
  gem 'rspec-rails', '~> 2.14.0.rc1'
  gem 'pivotal-tracker'
  gem 'launchy'
  gem 'capybara-webkit'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'jasmine-rails', git: 'git://github.com/mjm/jasmine-rails.git', ref: "ed30e865017fae143ca858074fa0d32c860ffccd"
end

group :production do
  gem 'rails_12factor'
end

