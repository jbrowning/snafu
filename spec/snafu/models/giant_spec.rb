require 'spec_helper'

module Snafu
  module Models
    describe Snafu::Models::Giant do

      GIANT_LIST = ["Alph", "Cosma", "Friendly", "Grendaline",
                    "Humbaba", "Lem", "Mab", "Pot", "Spriggan",
                    "Tii", "Zille" ]

      describe "#initialize" do
        let(:random_giant) { GIANT_LIST.sample }

        it "should populate values if given an options hash" do
          expected_name = random_giant
          expected_current_favor = rand(1000)
          expected_max_favor = expected_current_favor + 1
          expected_current_daily_favor = rand(1000)
          expected_max_daily_favor = expected_current_daily_favor + 1

          giant = Giant.new(
            :name => expected_name,
            :current_favor => expected_current_favor,
            :max_favor => expected_max_favor,
            :current_daily_favor => expected_current_daily_favor,
            :max_daily_favor => expected_max_daily_favor
          )

          giant.name.should eql(expected_name)
          giant.current_favor.should eql(expected_current_favor)
          giant.max_favor.should eql(expected_max_favor)
          giant.current_daily_favor.should eql(expected_current_daily_favor)
          giant.max_daily_favor.should eql(expected_max_daily_favor)
        end
      end
    end
  end
end