module Songkicky
  class Venue

    attr_accessor :name

    def initialize(hash)
      @name = hash['displayName']
    end
  end
end