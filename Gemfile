source 'http://rubygems.org'

gem 'rails', '3.0.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

platforms :ruby do
  gem 'pg'
  gem 'ruby-prof', :group => [:development, :test]
  gem 'zipruby'
end

platforms :ruby_19 do
  gem 'simplecov', '>= 0.4.0', :require => false, :group => :test
end

platforms :ruby_18 do
  gem 'system_timer'
end

platforms :jruby do
  gem 'jruby-openssl'
  gem 'activerecord-jdbc-adapter'
  gem 'jdbc-postgres', :require => false
  #gem 'jdbc-mysql', :require => false
  gem 'rubyzip2'
  gem 'glassfish'
end

gem 'fastercsv' if RUBY_VERSION < '1.9'

gem 'will_paginate', :git => 'git://github.com/wantful/will_paginate.git', :branch => 'rails3'
gem 'exception_notification', :require => 'exception_notifier'
gem 'delayed_job', '>=2.1.4'
gem 'state_machine'
gem 'prawn'
gem 'sunspot_rails', '>=1.2.1'
gem 'friendly_id'
gem 'inherited_resources'
gem 'has_scope'
gem 'nokogiri'
gem 'marc'
gem 'strongbox', '>=0.4.7'
gem 'acts-as-taggable-on'
gem 'dalli'
gem 'sitemap_generator', '>=2.0.1'
gem 'ri_cal'
gem 'file_wrapper'
gem 'paper_trail', '>=2.2.5'
gem 'recurrence'
gem 'prism'
gem 'money'
gem 'RedCloth', '>=4.2.7'
gem 'isbn-tools', :git => 'git://github.com/nabeta/isbn-tools.git', :require => 'isbn/tools'
gem 'attribute_normalizer'
gem 'configatron'
gem 'extractcontent'
gem 'cancan', '>=1.6.5'
gem 'scribd_fu'
gem 'devise', '>=1.4.0'
gem 'omniauth'
gem 'paperclip'
gem 'whenever', :require => false
gem 'amazon-ecs', '>=2.0.0', :require => 'amazon/ecs'
gem 'aws-s3', :require => 'aws/s3'
gem 'astrails-safe'
gem 'dynamic_form'
gem 'sanitize'
gem 'barby'
gem 'prawnto'
gem 'event-calendar', :require => 'event_calendar'
gem 'jpmobile', '>=1.0.0.pre.6'
#gem 'geokit'
gem 'geocoder'
gem 'acts_as_list', :git => 'git://github.com/haihappen/acts_as_list.git'
gem 'library_stdnums'
gem 'client_side_validations'
gem 'simple_form'
gem 'validates_timeliness'
gem 'rack-protection'

#gem 'oink', '>=0.9.2'
group :development do
  gem 'parallel_tests'
  gem 'jquery-rails'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'spork', '~> 0.9.0.rc8'
  gem 'metric_fu'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
