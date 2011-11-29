require 'snafu'

RSpec.configure do |config|
  config.filter_run_excluding :broken => true
end