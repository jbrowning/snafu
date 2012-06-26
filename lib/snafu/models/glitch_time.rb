module Snafu
  module Models
    # Class representing a Glitch date and time
    # 
    # there are 4435200 real seconds in a game year
    # there are 115200 real seconds in a game week
    # there are 14400 real seconds in a game day
    # there are 600 real seconds in a game hour
    # there are 10 real seconds in a game minute
    #
    class GlitchTime
      class InvalidTimestampError < Exception; end

      GLITCH_EPOCH = 1238562000
      Y_SECS = 4435200
      D_SECS = 14400
      H_SECS = 600
      M_SECS = 10
      DAYS_IN_MONTH = [29, 3, 53, 17, 73, 19, 13, 37, 5, 47, 11, 1]
      MONTH_NAMES = %w(Primuary Spork Bruise Candy Fever Junuary Septa Remember Doom Widdershins Eleventy Recurse)
      DAY_NAMES = %w(Hairday Moonday Twoday Weddingday Theday Fryday Standday Fabday Recurse)
      
      attr_reader :timestamp, :seconds_since_epoch
      
      def initialize(new_timestamp = Time.now)
        @timestamp = new_timestamp.to_i
        raise InvalidTimestampError if @timestamp < GLITCH_EPOCH
        @timestamp = timestamp
        @seconds_since_epoch = @timestamp - GLITCH_EPOCH
      end
      
      # Returns the number of years since the Glitch epoch
      def year
        (seconds_since_epoch / Y_SECS).to_i
      end
      
      # Returns the 1-based day of the current Glitch year
      def day_of_year
        (seconds_since_start_of_year / D_SECS).to_i + 1
      end
      
      # Returns the 1-based month of the year
      def month
        running_days = 0
        DAYS_IN_MONTH.each_with_index do |days, idx|
          running_days += days
          return idx + 1 if self.day_of_year <= running_days
        end
      end
      
      # Returns the name of the month
      def name_of_month
        MONTH_NAMES[self.month - 1]
      end
      
      # Returns the 0-based day of the month
      def day_of_month
        return self.day_of_year if self.month == 1
        ((self.day_of_year - 1) - DAYS_IN_MONTH.slice(0, (month - 1)).inject(:+)) + 1
      end

      alias_method :day, :day_of_month
      
      # Returns the 1-based day of the week
      def day_of_week
        return -1 if self.day_of_year == 308
        result = self.days_since_epoch % 8
        if result > 0
          result
        else
          8
        end

      end
      
      # Returns the name of the day
      def name_of_day
        if day_of_week == -1
          DAY_NAMES[day_of_week]
        else
          DAY_NAMES[day_of_week - 1]
        end
      end

      # Returns the number of game days since epoch
      def days_since_epoch
        self.day_of_year + (307 * year)
      end

      # Returns the hour of the day
      def hour
        # seconds_since_start_of_day / H_SECS
        (seconds_since_start_of_day / H_SECS).to_i
      end

      # Returns the minute of the hour
      #
      # == Options
      # 
      # +:padded+ - If true, will return a zero-padded string if the minute value is less than 10
      def minute(padded = false)
        min = (seconds_since_start_of_hour / M_SECS).to_i
        if padded && min < 10
          min = "0#{min}"
        end
        min
      end

      def to_s
        "#{self.hour}:#{self.minute(padded: true)}, #{self.name_of_day}, #{self.day_of_month} of #{self.name_of_month}, year #{self.year}"
      end

      private
      def seconds_since_start_of_year
        seconds_since_epoch - (Y_SECS * self.year)
      end
      
      def seconds_since_start_of_day
        seconds_since_start_of_year - (D_SECS * (self.day_of_year - 1))
      end

      def seconds_since_start_of_hour
        seconds_since_start_of_day - (H_SECS * self.hour)
      end

    end
  end
end