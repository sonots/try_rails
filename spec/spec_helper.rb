require 'spork'


  require 'uri'
  require 'cgi'
  require 'ir_b/pry'


# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rails'
require 'capybara/rspec'
require 'forwardable'
require 'database_cleaner'
require 'shoulda-matchers'

if ENV["REMOTE_HOST"]
  require 'capybara/mechanize'
  require 'ext/capybara_mechanize_setup'
  require 'capybara/httpclient'
  require 'capybara/json'
else
  require 'ext/capybara_racktest_setup'
end

$http_verbs  = %w[ get post put delete post_json put_json cookies set_cookie cookies clear_all clear_cookies verify_mode set_client_cert_file parsed_body ] #set_cookie cookie reset! ]
$to_delegate = $http_verbs + %w[ status_code response_headers body ]

if ENV['REMOTE_HOST']
  Capybara.default_host = ENV['REMOTE_HOST']
  Capybara.app_host = ENV['REMOTE_HOST']
  Capybara.default_driver = :httpclient
  Capybara.run_server = false
end

module Capybara
  extend Forwardable
  def_delegators :page, *$to_delegate

  class Session
    extend Forwardable
    def_delegators :driver, *$http_verbs
  end
end



# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  #config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  #config.order = "random"
  
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true

  config.after(:all) do
  end

  config.include Capybara,            :example_group => { :file_path => %r"spec/controllers" }
end


