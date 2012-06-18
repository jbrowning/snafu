module Snafu
  module Models
    # Defines a class for Glitch Giants
    #
    class Giant
      attr_reader :name, :cur_favor, :max_favor, :cur_daily_favor, :max_daily_favor

      alias_method :current_favor, :cur_favor
      alias_method :current_daily_favor, :cur_daily_favor

      def initialize(options={})
        @name = options[:name] || options["name"]
        @cur_favor = (options[:cur_favor] || options["cur_favor"] || 0).to_i
        @max_favor = (options[:max_favor] || options["max_favor"] || 0).to_i
        @cur_daily_favor = (options[:cur_daily_favor] || options["cur_daily_favor"] || 0).to_i
        @max_daily_favor = (options[:max_daily_favor] || options["max_daily_favor"] || 0).to_i
      end

    end
  end
end