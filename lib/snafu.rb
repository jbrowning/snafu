$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'httparty'

require "snafu/version"
require "snafu/locations"
require "snafu/models"
require "snafu/achievements"
require "snafu/giants"
require "snafu/util"

# Must be required last
require "snafu/client"