module Snafu
  module Models
    # Provides a simple class to represent image information returned by the
    # Glitch API.
    # 
    class GlitchImage
      attr_reader :url, :width, :height
      # Accepts an options hash with <tt>:url</tt>, <tt>:width</tt>, and
      # <tt>:height</tt> properties
      def initialize(options={})
        @url = options[:url]
        @width = options[:width].to_i || 0
        @height = options[:height].to_i || 0
      end
    end
  end
end