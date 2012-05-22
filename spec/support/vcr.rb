VCR.config do |config|
  # config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.stub_with :fakeweb
  #TWO_WEEKS = 14 * 24 * 60 * 60
  #config.default_cassette_options = { :re_record_interval => TWO_WEEKS }
end

RSpec.configure do |config|
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_")
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name) { example.call }
  end
end