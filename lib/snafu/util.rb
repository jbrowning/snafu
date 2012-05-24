module Snafu
  # Contains convenience methods that don't seem to fit anywhere else
  module Util
    def glitch_time(timestamp = nil)
      if timestamp
        Snafu::Models::GlitchTime.new(timestamp)
      else
        Snafu::Models::GlitchTime.new
      end
    end
  end
end