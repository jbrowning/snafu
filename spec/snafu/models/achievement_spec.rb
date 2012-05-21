require 'spec_helper'

module Snafu
  module Models
    describe Snafu::Models::Achievement do
      before(:each) do
        @valid_options = {
          name: "a name",
          desc: "a description",
          url: "http://example.com",
          image_60: "http://example.com/60.png",
          image_180: "http://example.com/180.png"
        }
        @achievement = Achievement.new @valid_options
      end

      it "should populate values if given an options hash" do
        @achievement.name.should eql(@valid_options[:name])
        @achievement.description.should eql(@valid_options[:desc])
        @achievement.url.should eql(@valid_options[:url])
        @achievement.image_60.url.should eql(@valid_options[:image_60])
        @achievement.image_180.url.should eql(@valid_options[:image_180])
      end
      
      it "should alias #description as #desc" do
        @achievement.desc.should eql(@achievement.description)
      end

    end
  end
end