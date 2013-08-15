source 'http://rubygems.org'

gem 'rails', '3.1.12'

gem 'sqlite3'
gem 'capistrano', '~> 2.14.0'
gem 'thin'
gem 'httparty'
gem 'rb-readline', '0.4.2'	
gem 'gravatar_image_tag'

gem 'highline', '>= 1.6.12'


gem 'simplecov',      :require => false, :group => :test
gem 'simplecov-rcov', :require => false, :group => :test


group :production do
  gem 'pg'
end

group :ticker_development do
  gem 'pg'
end

group :development do
  gem 'rails-erd'
end

gem 'therubyracer', '>= 0.11.0'          # missing javascript runtime
gem 'libv8'

gem 'will_paginate'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# make api requests within rails
gem 'httparty'


gem 'ci_reporter'


group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'test-unit', '~> 2.0.0'
end
