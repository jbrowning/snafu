require 'spec_helper'

describe Snafu::Achievements do
  before(:all) do
    @snafu = Snafu.new
  end

  let(:all_achievements) { @snafu.get_achievements }

  describe "#get_achievements_count" do
    it "should return the count of all achievements in Glitch" do
      VCR.use_cassette("achievements.listAll") do
        achievement_count = @snafu.call("achievements.listAll").parsed_response["total"]
        @snafu.achievement_count.should eql(achievement_count)
      end
    end
  end

  describe "#get_achievements" do
    it "should return an array", :vcr do
       all_achievements.should be_an(Array)
    end

    it "should return an array of the same size as the total number of achievements" do
      VCR.use_cassette("achievements.listAll", :record => :new_episodes) do
        all_achievements = @snafu.get_achievements
        achievements_count = @snafu.last_request_result["total"]
        all_achievements.count.should eql(achievements_count)
      end
    end

    it "should return an array of Achievement objects", :vcr do
      all_achievements.each do |achievement|
        achievement.should be_a(Snafu::Models::Achievement)
      end
    end

    it "should return an array of fully-populated achievements" do
      VCR.use_cassette("achievements.listAll") do
        all_achievements.each do |achievement|
          achievement.name.should_not be_nil
          achievement.desc.should_not be_nil
          achievement.url.should_not be_nil
          achievement.image_60.should_not be_nil
          achievement.image_180.should_not be_nil
        end
      end
    end
  end

end