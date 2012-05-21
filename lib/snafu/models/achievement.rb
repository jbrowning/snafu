module Snafu
  module Models
    class Achievement
      attr_reader :name, :description, :url, :image_60, :image_180
      alias_method :desc, :description
      def initialize(options = {})
        @name = options[:name]
        @description = options[:description] || options[:desc]
        @url = options[:url]
        if options[:image_60].is_a? String
          @image_60 = GlitchImage.new(url: options[:image_60])
        elsif options[:image_60].is_a? GlitchImage
          @image_60 = options[:image_60]
        end
        if options[:image_180].is_a? String
          @image_180 = GlitchImage.new(url: options[:image_180])
        elsif options[:image_180].is_a? GlitchImage
          @image_180 = options[:image_180]
        end
      end
    end
  end
end