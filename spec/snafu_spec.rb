require 'spec_helper'

describe Snafu do
  
  it "should return a Snafu::Client object if supplied with valid parameters" do
    glitch_client = Snafu.new()
  end

  it "should retain the Oauth Token" do
    test_oauth_token = rand(100000).to_s
    glitch_client = Snafu.new(:api_key => GLITCH_API_KEY, :oauth_token => test_oauth_token)
    glitch_client.oauth_token.should eql(test_oauth_token)
  end

end