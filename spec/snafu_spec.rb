require 'spec_helper'

describe Snafu do
  it "should raise an ArgumentError if supplied with no arguments" do
    expect { Snafu.new() }.to raise_error
  end

  it "should raise an ArgumentError if supplied with an empty string" do
    expect { Snafu.new("") }.to raise_error
  end

  it "should retain the API key" do
    test_key = "the-test-key"
    snafu = Snafu.new(test_key)
    snafu.api_key.should eql(test_key)
  end
end