source 'http://rubygems.org'

gem 'rails', '~> 3.2.0'
gem 'json'
gem 'rails_config', '>= 0.2.5'
gem 'mysql2'
gem 'kaminari'
gem 'httpclient'

# for db data creation
gem 'machinist', '~> 2.0.0'

group :development, :test do
  # for server testing
  gem 'rspec-rails'
  gem 'capybara', '0.4.1.2'
  gem 'capybara-mechanize'
  #gem 'httpclient'

  gem 'capybara-json', :git => 'git@github.com:sonots/capybara-json', :branch => 'master'
  #gem 'capybara-json', :path => '../capybara-json'

  # mock
  gem 'rr'
  gem 'ww'

  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'sham'
  gem 'faker'
  gem 'delorean'

  # for faster test
  gem 'spork',  '~> 0.9.0.rc'
  gem 'prefetch-rspec', '~> 0.1.4'
  gem 'watchr'

  # metrics
  gem 'simplecov-rcov', :require => false

  # for debug
  gem 'pry'
  gem 'pry-nav'
  gem 'ir_b'
  gem 'tapp'
  gem 'gem-open'
end
