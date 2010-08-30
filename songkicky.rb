$:.unshift(File.dirname(__FILE__))

require 'lib/artist'
require 'lib/event'
require 'lib/metro_area'

module Songkicky
  class << self
    attr_accessor :apikey
  end
end


