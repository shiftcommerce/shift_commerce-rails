require "rack-timeout"
Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout, service_timeout: ENV.fetch('WEB_TIMEOUT', 15).to_i
