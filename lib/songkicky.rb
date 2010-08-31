$:.unshift(File.dirname(__FILE__))

require 'artist'
require 'event'
require 'metro_area'

module Songkicky
  class << self
    attr_accessor :apikey
  end
end


