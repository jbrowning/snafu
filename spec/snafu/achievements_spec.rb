require 'spec_helper'

describe Snafu::Achievements do
  before(:all) do
    @snafu = Snafu.new
    @all_achievements = @snafu.get_achievements
  end

  describe "#get_achievements" do
    it "should return an array" do
      @all_achievements.should be_an(Array)
    end

    it "should return an array of the same size as the total number of achievements" do
      
    end

    it "should return an array of Achievement objects" do
      @all_achievements.each do |achievement|
        achievement.should be_an(Achievement)
      end
    end

    it "should return an array of fully-populated achievements"
  end

end