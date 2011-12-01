module Snafu
  module Models
    class GlitchImage
      attr_reader :url, :width, :height
      def initialize(options={})
        @url = options[:url]
        @width = options[:width].to_i || 0
        @height = options[:height].to_i || 0
      end
    end
  end
end