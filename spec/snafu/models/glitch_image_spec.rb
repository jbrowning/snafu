require 'spec_helper'

module Snafu
  module Models
    describe Snafu::Models::GlitchImage do
      before(:each) do
        @valid_image = GlitchImage.new(
          :url => "http://example.com",
          :width => 100,
          :height => 100
        )
      end
      context "initialize()" do
        it "should retain all parameters" do
          @valid_image.url.should_not be_nil
          @valid_image.height.should be > 0
          @valid_image.width.should be > 0
        end

        it "should convert a string width argument into an integer" do
          glitch_image = GlitchImage.new(
            :width => "100"
          )
          glitch_image.width.should be_a Integer      
        end

        it "should convert a string height argument into an integer" do
          glitch_image = GlitchImage.new(
            :height => "100"
          )
          glitch_image.height.should be_a Integer      
        end
      end
    end
  end
end