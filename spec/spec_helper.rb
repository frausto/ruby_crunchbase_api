$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__))

# External
require 'rubygems'
require 'rspec'
require 'pry'
require 'webmock/rspec'
require 'yaml'

# Library
require 'crunchbase'

WebMock.disable_net_connect!(:allow_localhost => true)

yaml = YAML.load_file(File.join(File.dirname(__FILE__), 'crunchbase.yml'))
Crunchbase::API.key   = yaml['user_key']
Crunchbase::API.debug = false #yaml['debug']

Dir[File.expand_path('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  
  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :each do
    
  end
end
