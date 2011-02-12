require 'date'

module Songkicky

  class Event
    include JsonApi

    attr_accessor :id,
                  :name,
                  :date,
                  :popularity,
                  :venue,
                  :lat, :lng,
                  :metro_area,
                  :artists, :headliners, :supports,
                  :festival,
                  :type

    def initialize(hash)
      @id   = hash['id']
      @type = hash['type']

      @festival = Festival.new(hash['series']) if @type && @type.downcase == 'festival'

      @name = hash['displayName']

      @popularity = hash['popularity']

      @date = Date.strptime(hash['start']['date'], '%Y-%m-%d') if hash['start']

      if hash['location']
        @lat  = hash['location']['lat']
        @lng  = hash['location']['lng']
      end
      
      @venue = Venue.new(hash['venue'])
      @metro_area = MetroArea.new(hash['venue']['metroArea']) if hash['venue']

      if hash['performance']
        @artists = hash['performance'].map {|p| Artist.new(p['artist'])}

        headlines = hash['performance'].select {|p| p['billing'] == 'headline'}
        @headliners = headlines.map {|p| Artist.new(p['artist'])}

        supports = hash['performance'].select {|p| p['billing'] == 'support'}
        @supports = supports.map {|p| Artist.new(p['artist'])}
      end
    end

    def festival?
      !@festival.nil?
    end

    def setlist
      json_data_from("events/#{id}/setlists.json", 'setlist')
    end
  end
end
