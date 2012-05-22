require 'spec_helper'

describe Snafu::Achievements do
  before(:all) do
    @snafu = Snafu.new
  end

  describe "#get_achievements" do
    it "should return an array" do
      all_achievements = @snafu.get_achievements
      all_achievements.should be_an(Array)
    end
    it "should return an array of Achievement objects"
    it "should return an array of fully-populated achievements"
    it "should return an array of the same size as the total number of achievements"
  end

end