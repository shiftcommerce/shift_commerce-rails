WebMock.disable_net_connect!
RSpec.configure do |config|
  config.before(:each) do
    WebMock.reset!
  end
  config.around(:each, webmock: false) do |example|
    WebMock.disable!
    example.run
    WebMock.enable!
  end
end
