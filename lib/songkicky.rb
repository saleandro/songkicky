$:.unshift(File.dirname(__FILE__))

require 'artist'
require 'event'
require 'metro_area'
require 'user'
require 'venue'
require 'festival'

module Songkicky
  class << self
    attr_accessor :apikey
  end

  class Error < StandardError; end
end


