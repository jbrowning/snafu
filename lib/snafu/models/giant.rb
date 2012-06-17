module Snafu
  module Models
    # Defines a class for Glitch Giants
    #
    class Giant
      attr_reader :name, :current_favor, :max_favor, :current_daily_favor, :max_daily_favor

      def initialize(options={})
        @name = options[:name] || options["name"]
        @current_favor = options[:current_favor] || options["current_favor"]
        @max_favor = options[:max_favor] || options["max_favor"]
        @current_daily_favor = options[:current_daily_favor] || options["current_daily_favor"]
        @max_daily_favor = options[:max_daily_favor] || options["max_daily_favor"]
      end

    end
  end
end