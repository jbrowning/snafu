module Snafu
  module Models
    # Class representing a Glitch date and time
    # 
    
    # there are 4435200 real seconds in a game year
    # there are 14400 real seconds in a game day
    # there are 600 real seconds in a game hour
    # there are 10 real seconds in a game minute
    #
    class GlitchTime
      class InvalidTimestampError < Exception; end

      GLITCH_EPOCH = 1238562000
      Y_SECS = 4435200
      D_SECS = 14400
      DAYS_IN_MONTH = [29, 3, 53, 17, 73, 19, 13, 37, 5, 47, 11, 1]
      MONTH_NAMES = %w(Primuary Spork Bruise Candy Fever Junuary Septa Remember Doom Widdershins Eleventy Recurse)
      
      attr_reader :timestamp, :seconds_since_epoch
      
      def initialize(timestamp = nil)
        timestamp = timestamp.to_i
        raise InvalidTimestampError if timestamp < GLITCH_EPOCH
        @timestamp = timestamp
        @seconds_since_epoch = @timestamp - GLITCH_EPOCH
      end
      
      def year
        (seconds_since_epoch / Y_SECS).to_i
      end
      
      def day_of_year
        (seconds_since_start_of_year / D_SECS).to_i + 1
      end
      
      def month
        running_days = 0
        DAYS_IN_MONTH.each_with_index do |days, idx|
          running_days += days
          return idx + 1 if day_of_year <= running_days 
        end
      end
      
      def name_of_month
        MONTH_NAMES[month - 1]
      end
      
      def day_of_month
        self.day_of_year - DAYS_IN_MONTH.slice(0, month - 1).inject(:+)
      end
      
      def day_of_week
        return -1 if day_of_year == 308
        days_since_epoch % 8
      end
      
      private
      def seconds_since_start_of_year
        seconds_since_epoch - (Y_SECS * self.year)
      end
      
      def days_since_epoch
        self.day_of_year + (307 * year)
      end
      
    end
  end
end