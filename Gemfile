source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

gem 'bootstrap-glyphicons'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'devise', '~> 3.4.1'

gem 'jquery-turbolinks'

gem 'mandrill-api'

gem 'icalendar'

gem 'roadie', '~> 3.0.4'
gem 'roadie-rails'

gem 'whenever', :require => false

gem 'dotenv-rails', :groups => [:development, :test]
# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'chili'

gem 'pg', '0.17.1'

gem "faker"

gem 'StreetAddress', require: 'street_address'

gem 'rack-reverse-proxy', require: 'rack/reverse_proxy', 
    git: 'git://github.com/nextmat/rack-reverse-proxy', branch: 'content_length'

gem 'cloudinary'

group :development, :test do
  gem "factory_girl_rails"
  gem 'rspec-rails',  '~> 3.0.0'
end

group :test do
  gem 'capybara', '~> 2.3.0'
  gem 'poltergeist'
end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'newrelic_rpm'
end
group :chili do
  gem 'sign_up_feature', path: 'lib/chili/sign_up_feature'
end
