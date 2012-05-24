require 'spec_helper'

describe Snafu do
  
  it "should return a Snafu::Client object if supplied with valid parameters" do
    glitch_client = Snafu.new({:oauth_token => GLITCH_OAUTH_TOKEN})
  end

  it "should retain the Oauth Token" do
    test_oauth_token = GLITCH_OAUTH_TOKEN
    glitch_client = Snafu.new(:api_key => GLITCH_API_KEY, :oauth_token => GLITCH_OAUTH_TOKEN)
    glitch_client.oauth_token.should eql(test_oauth_token)
  end

end