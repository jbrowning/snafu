require 'spec_helper'

module Snafu
  module Models
    describe GlitchTime do
      let(:glitch_epoch) { 1238562000 }
      let(:secs_in_game_year) { 4435200 }
      let(:secs_in_game_week) { 115200 }
      let(:secs_in_game_day) { 14400 }
      let(:secs_in_game_hour) { 600 }
      let(:secs_in_game_minute) { 10 }
      let(:days_in_month) { [29, 3, 53, 17, 73, 19, 13, 37, 5, 47, 11, 1] }
      let(:names_of_months) { %w(Primuary Spork Bruise Candy Fever Junuary Septa Remember Doom Widdershins Eleventy Recurse) }
      let(:names_of_days) { %w(Hairday Moonday Twoday Weddingday Theday Fryday Standday Fabday Recurse) }
  
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

        it "should set the timestamp to the current time if no time is specified" do
          Timecop.freeze(Time.now)
          time = GlitchTime.new
          time.timestamp.should eql(Time.now.to_i)
        end
      end
      
      describe "GlitchTime.at" do
        it "should return a GlitchTime at the specified day/month/year" do
          pending
          time = GlitchTime.at(23,1,2)
          time.year.should == 23
          time.month.should == 0
          time.day.should == 1
        end

        it "should return midnight if no time is specified"
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
        it "should return the 1-based day of the year" do
          (0..307).each do |day| 
            GlitchTime.new(glitch_epoch + secs_in_game_day * day).day_of_year.should eql(day + 1)
          end
        end
        
        it "should roll back to 1 at the end of a game year" do
          GlitchTime.new(glitch_epoch + secs_in_game_year).day_of_year.should eql(1)
        end
      end
      
      describe "#month" do
        it "should return the month of the year" do          
          (1..12).each do |month|
            # Create a time right before midnight on the first day of the specified month
            time = GlitchTime.new(beginning_of_first_day_of_month(month))
            time.month.should eql(month)
          end
        end
      end
      
      describe "#day_of_month" do
        it "should return the day of the month" do
          (1..12).each do |month|
            time = GlitchTime.new(beginning_of_first_day_of_month(month))
            time.day_of_month.should eql(1)
          end
        end
      end
      
      describe "#name_of_month" do
        it "should return the name of the month" do
          (1..12).each do |month|
            GlitchTime.new(beginning_of_first_day_of_month(month)).name_of_month.should eql(names_of_months[month - 1])
          end
        end
      end

      describe "#day_of_week" do
        it "should return the correct day of week" do
          (1..8).each do |day| 
            time = GlitchTime.new(glitch_epoch + secs_in_game_day * (day - 1))
            time.day_of_week.should == day
          end
        end

        it "should return 3 for the day we wrote this code" do
          time = GlitchTime.new(1327359466)
          time.day_of_week.should == 3
        end

        it "should return Twoday for the day we wrote this code" do
          time = GlitchTime.new(1327359466)
          time.name_of_day.should eql("Twoday")
        end
        
        it "should return -1 for the day if it is Recurse day" do
          5.times { |year| GlitchTime.new(glitch_epoch + secs_in_game_year * (year + 1) - 1).day_of_week.should == -1 }
        end
      end

      describe "#name_of_day" do
        it "should return the name of the day" do
          8.times { |day| GlitchTime.new(glitch_epoch + (secs_in_game_day * day)).name_of_day.should eql(names_of_days[day])}
        end
        it "should return 'Recurse' if it is Recurse day" do
          5.times { |year| GlitchTime.new(glitch_epoch + secs_in_game_year * (year + 1) - 1).name_of_day.should eql("Recurse")}
        end
      end

      describe "#hour" do
        it "should return the hour of the day" do
          24.times { |hour| GlitchTime.new(glitch_epoch + (hour * secs_in_game_hour)).hour.should == hour}
          24.times { |hour| GlitchTime.new(glitch_epoch + secs_in_game_day + (hour * secs_in_game_hour)).hour.should == hour}
        end
      end

      describe "#minute" do
        it "should return the minute of the hour" do
          60.times do |minute|
            time = GlitchTime.new(glitch_epoch + secs_in_game_day + (minute * secs_in_game_minute))
            time.minute.should == minute
          end
        end

        it "should pad the minute if passed the :padded => true option" do
          10.times do
            time = random_time
            while time.minute >= 10 do
              time = random_time
            end
            time.minute(padded: true).to_s.should match(/\A0\d\z/)
          end
        end
      end

      describe "#to_s" do
        it "should display the full time" do
          time = GlitchTime.new
          pattern_string = "#{time.hour}:#{time.minute(padded: true)}, #{time.name_of_day}, #{time.day_of_month} of #{time.name_of_month}, year #{time.year}"
          time.to_s.should match(pattern_string)
        end
      end


      # Returns the 1-based day of year for the first day in the given month.
      def day_of_year_for_first_day_of_month(month_number)
        result = 1
        result = days_in_month[0..month_number-1].inject(:+) if month_number > 1
        result
      end

      # Returns a timestamp representing midnight on the first day of the given month. The month is
      # 1-based so Primuary would be month 1, Spork would be month 2, and so on. 
      #
      def beginning_of_first_day_of_month(month_number)
        seconds_in_elapsed_days = 0
        if month_number == 1
          seconds_in_elapsed_days = 0
        else
          seconds_in_elapsed_days = (days_in_month[0..month_number - 2].inject(:+)) * secs_in_game_day
        end
        glitch_epoch + seconds_in_elapsed_days
      end

      def random_time(seed = 1000)
        GlitchTime.new(glitch_epoch + rand(1000))
      end
    end
  end
end