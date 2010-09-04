module Songkicky
  class Festival
    attr_accessor :name

    def initialize(hash)
      @name = hash['displayName']
    end
  end
end