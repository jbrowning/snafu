module Snafu
  # Contains convenience methods that don't seem to fit anywhere else
  module Util
    def glitch_time(timestamp = Time.now)
      Snafu::Models::GlitchTime.new(timestamp)
    end
  end
end