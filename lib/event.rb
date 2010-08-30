module Songkicky

  class Event

    attr_accessor :id,
                  :name,
                  :date,
                  :lat, :lng,
                  :metro_area

    def initialize(hash)
      @id   = hash['id']
      @name = hash['displayName']
      @date = Date.parse(hash['start']['date'])
      @lat  = hash['location']['lat']
      @lng  = hash['location']['lng']
      @metro_area = MetroArea.new(hash['venue']['metroArea'])
    end
  end
end
