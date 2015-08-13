source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.11'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'pg'



gem 'psych'

gem 'htmlcompressor', github: 'paolochiodi/htmlcompressor', branch: 'master'

#######################################
gem 'foundation-rails', github: 'zurb/foundation-rails'
gem 'foundation_rails_helper'

gem 'simple_form'
gem 'slim'
gem 'slim-rails'
gem 'active_link_to'

gem 'actionview-encoded_mail_to'
group :development do
  gem 'rails_layout'
  gem 'capistrano', '~> 2.15.5'
  gem 'rvm-capistrano', require: false
  gem 'execjs'
  gem 'therubyracer'
  gem 'spring'
  gem 'quiet_assets'
  
end

gem 'polyamorous'

# caching
#gem 'dalli'
gem 'memcached_store'


gem 'browser' # for browsers detection
gem 'autonumeric-rails'
gem 'wiselinks'

gem 'devise'
gem 'authority'
gem 'rolify'

gem 'rails_admin', git: 'https://github.com/sferik/rails_admin.git'
gem 'paper_trail', '~> 3.0.0' # track changes in models data

gem 'russian', '~> 0.6.0'
gem 'kaminari'

gem 'carrierwave'
gem "mini_magick"



gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4.1"

gem 'jquery-turbolinks'

gem 'paranoia' #, :github => "radar/paranoia", :branch => "rails4"

gem 'nested_form'

gem 'state_machine'

gem 'jquery-ui-themes'

gem 'bullet', group: :development

#######################################


# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
#gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


group :development, :test do
  gem 'rspec-rails'
  gem "factory_girl_rails", "~> 4.0"
  gem 'database_cleaner'
  gem 'faker'
  gem 'yaml_db'
end
group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'selenium-webdriver'
end


gem 'sprockets', '~> 2.0' # version 3.0 has broken with capistrano 2. wait for fix

gem 'comfortable_mexican_sofa', '~> 1.12.0'