source 'http://rubygems.org'

gem 'rails', '~>4.1'
gem 'pg'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
gem 'unicorn'
# Deploy with Capistrano
group :development do
  gem 'capistrano3-delayed-job', '~> 1.4', require: false
  gem 'capistrano', '~> 3.4', require: false
  gem 'capistrano-chruby', require: false
  gem 'capistrano-rails', '~> 1.1.1', require: false
  gem 'capistrano-unicorn-nginx', '~> 3.3', require: false
  gem 'capistrano-cookbook', require: false
  gem 'capistrano-secrets-yml', '~> 1.0.0', require: false
  gem 'cap-deploy-tagger', require: false
end

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'delayed_job_active_record'
gem 'daemons'
gem 'thin', :group => :development
gem 'active_model_serializers'
gem 'activeadmin', github: 'activeadmin'
gem 'devise'

gem 'rails_admin_clone'
gem 'rails_admin'
gem 'paper_trail', '~> 3.0' # 4.0.beta is not supported by rails_admin

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
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

gem 'exception_notification'

# to dump db
gem 'yaml_db'

# to overview database
# gem 'pghero'

# gem for GCM:
gem 'rpush'

gem 'paperclip', '~> 4.2'
gem 'aws-sdk', '<2.0'

gem 'nokogiri', '1.6.5' # trying to fig bug of nokogiri not being installed
