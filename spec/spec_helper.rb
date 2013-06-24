$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each do |f|
  require f
end

RSpec.configure do |config|
  config.mock_with :rspec
end
