require 'snafu'
require 'vcr'

VCR.config do |config|
  TWO_WEEKS = 14 * 24 * 60 * 60 # or use 7.days if you're using ActiveSupport
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.stub_with :fakeweb
  config.default_cassette_options = { :re_record_interval => TWO_WEEKS }
end

RSpec.configure do |config|
  config.filter_run_excluding :broken => true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name) { example.call }
  end
end

