require 'spec_helper'

describe Snafu::Util do
  let(:glitch_epoch) { 1238562000 }
  let(:snafu) { Snafu.new }

  describe "#glitch_time" do
    it "should return the current GlitchTime if given no arguments" do
      Timecop.freeze(Time.now)
      glitch_time = snafu.glitch_time
      direct_time = Snafu::Models::GlitchTime.new
      glitch_time.timestamp.should eql(direct_time.timestamp)
    end

    it "should return the same GlitchTime if given a Glitch timestamp" do
      timestamp = glitch_epoch + rand(1000)
      glitch_time = snafu.glitch_time(timestamp)
      direct_time = Snafu::Models::GlitchTime.new(timestamp)
      glitch_time.timestamp.should eql(direct_time.timestamp)
    end
  end
end