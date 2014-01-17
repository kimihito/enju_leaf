#require 'enju_biblio'
#require 'enju_library'
require 'enju_seed'
require 'devise'
#require 'enju_manifestation_viewer'
require 'redcarpet'
require 'mobylette'
require 'rails_autolink'
require 'devise-encryptable'
require 'sitemap_generator'
#require 'redis-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'resque_scheduler/server'
require 'protected_attributes'

module EnjuLeaf
  class Engine < ::Rails::Engine
    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( mobile.js mobile.css print.css )
    end
  end
end
