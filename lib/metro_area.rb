module Songkicky
  class MetroArea

    attr_accessor :id,
                  :name,
                  :lat, :lng,
                  :state,
                  :country

    def initialize(hash)
      @id      = hash['id']
      @name    = hash['displayName']
      @state   = hash['state']['displayName'] if hash['state']
      @country = hash['country']['displayName']
    end
  end
end
