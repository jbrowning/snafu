require 'snafu'
require 'vcr'
require 'timecop'
require 'api_key' if File.exists?(File.dirname(__FILE__) + "/api_key.rb")

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :fakeweb
  c.configure_rspec_metadata!
  #TWO_WEEKS = 14 * 24 * 60 * 60
  #c.default_cassette_options = { :re_record_interval => TWO_WEEKS }
end

RSpec.configure do |config|
  config.filter_run_excluding :broken => true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.extend VCR::RSpec::Macros
end

if !defined? GLITCH_API_KEY
  GLITCH_API_KEY = "testing-key"
end

if !defined? GLITCH_OAUTH_TOKEN
  GLITCH_OAUTH_TOKEN = "testing-token"
end

# Handy time and date calculations
class Numeric
  def milliseconds; self/1000.0; end
  def seconds; self; end
  def minutes; self*60; end
  def hours; self*60*60; end
  def days; self*60*60*24; end
  def weeks; self*60*60*24*7; end
end
