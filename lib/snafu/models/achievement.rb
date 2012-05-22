module Snafu
  module Models
    class Achievement
      attr_reader :name, :description, :url, :image_60, :image_180
      alias_method :desc, :description
      def initialize(options = {})
        @name = options["name"]
        @description = options["description"] || options["desc"]
        @url = options["url"]
        @image_60 = parse_image options["image_60"]
        @image_180  = parse_image options["image_180"]
      end

      def parse_image(image)
        if image.is_a? String
          return GlitchImage.new(url: image)
        elsif image.is_a? GlitchImage
          return image
        end
        nil
      end
    end
  end
end