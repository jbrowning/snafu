require 'spec_helper'

module Snafu
  module Models
    describe GlitchTime do
      let(:glitch_epoch) { 1238562000 }
      let(:secs_in_game_year) { 4435200 }
      let(:secs_in_game_day) { 14400 }
      let(:days_in_month) { [nil, 29, 3, 53, 17, 73, 19, 13, 37, 5, 47, 11, 1] }
      let(:names_of_months) { %w(Primuary Spork Bruise Candy Fever Junuary Septa Remember Doom Widdershins Eleventy Recurse) }
  
      describe "#new" do
        it "should retain the timestamp that is passed" do
          time = GlitchTime.new(glitch_epoch)
          time.timestamp.should eql(glitch_epoch)
        end
        
        it "should raise an error when given a time before the glitch epoch" do
          lambda { GlitchTime.new(glitch_epoch - 1) }.should raise_error(GlitchTime::InvalidTimestampError)
        end
        
        it "should set the correct timestamp if given a valid Time object" do 
          GlitchTime.new(Time.at(glitch_epoch)).timestamp.should eql(glitch_epoch)
        end
      end
      
      describe "#seconds_since_epoch" do
        it "should return the seconds since the glitch epoch" do
          time = GlitchTime.new(glitch_epoch + 12345)
          time.seconds_since_epoch.should eql(12345)
        end
      end
      
      describe "#year" do
        it "should return 0 if timestamp is the Glitch epoch" do
          time = GlitchTime.new(glitch_epoch)
          time.year.should eql(0)
        end
        
        it "should return 1 for a timestamp one game year from the Glitch epoch" do
          time = GlitchTime.new(glitch_epoch + secs_in_game_year)
          time.year.should eql(1)
        end
      end
      
      describe "#day_of_year" do
        it "should return the day of the year" do
          5.times { |day| GlitchTime.new(glitch_epoch + secs_in_game_day * day).day_of_year.should eql(day + 1) }
        end
        
        it "should roll back to 1 at the end of a game year" do
          GlitchTime.new(glitch_epoch + secs_in_game_year).day_of_year.should eql(1)
        end
      end
      
      describe "#month" do
        it "should return the month of the year" do          
          5.times do |month|
            GlitchTime.new(glitch_epoch + day_of_year_for_month_and_day(month + 1, 1) * secs_in_game_day).month.should eql(month + 1)
          end
        end
      end
      
      describe "#day_of_month" do
        it "should return the day of the month" do
          (3..7).each do |n|
            GlitchTime.new(glitch_epoch + day_of_year_for_month_and_day(n, n) * secs_in_game_day).day_of_month.should eql(n)
          end
        end
      end
      
      describe "#name_of_month" do
        it "should return the name of the month" do
          (3..12).each do |n|
            GlitchTime.new(glitch_epoch + day_of_year_for_month_and_day(n, 1) * secs_in_game_day).name_of_month.should eql(names_of_months[n-1])
          end
        end
      end
      
      describe "#day_of_week" do
        it "should return 3 for the day we wrote this code" do
          time = GlitchTime.new(1327359466)
          time.day_of_week.should == 3
        end
        
        it "should return -1 for the day if it is Recurse day" do
          5.times { |year| GlitchTime.new(glitch_epoch + secs_in_game_year * (year + 1) - 1).day_of_week.should == -1 }
        end
        
      end
      
      def day_of_year_for_month_and_day(month_number, day)
        return day if month_number == 1
        days_in_month[1..month_number - 1].inject(:+) + day - 1
      end
    end
  end
end