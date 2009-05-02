require File.expand_path(File.join(File.dirname(__FILE__), "../test_helper"))

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

def pending_context(*args, &block)
end
