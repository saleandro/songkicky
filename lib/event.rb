require 'date'

module Songkicky

  class Event

    attr_accessor :id,
                  :name,
                  :date,
                  :popularity,
                  :venue,
                  :lat, :lng,
                  :metro_area,
                  :headliners,
                  :festival,
                  :type

    def initialize(hash)
      @id   = hash['id']
      @type = hash['type']

      @festival = Festival.new(hash['series']) if @type.downcase == 'festival'

      @name = hash['displayName']

      @popularity = hash['popularity']

      @date = Date.strptime(hash['start']['date'], '%Y-%m-%d')

      @lat  = hash['location']['lat']
      @lng  = hash['location']['lng']
      @venue = Venue.new(hash['venue'])
      @metro_area = MetroArea.new(hash['venue']['metroArea'])

      headlines = hash['performance'].select {|p| p['billing'] == 'headline'}
      @headliners = headlines.map {|p| Artist.find_by_name(p['artist']['displayName'])}
    end
  end
end
