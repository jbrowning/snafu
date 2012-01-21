require 'snafu'
require 'vcr'
require 'api_key' if File.exists?(File.dirname(__FILE__) + "/api_key.rb")

VCR.config do |config|
  TWO_WEEKS = 14 * 24 * 60 * 60
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.stub_with :fakeweb
  #config.default_cassette_options = { :re_record_interval => TWO_WEEKS }
  #config.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.filter_run_excluding :broken => true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.extend VCR::RSpec::Macros
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name) { example.call }
  end
end

if !defined? GLITCH_API_KEY
  GLITCH_API_KEY = "testing-key"
end

if !defined? GLITCH_OAUTH_TOKEN
  GLITCH_OAUTH_TOKEN = "testing-token"
end
