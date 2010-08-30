require 'lib/json_api'

module Songkicky
  class Artist
    include JsonApi

    class << self
      def find_by_mbid(mbid)
        Artist.new(mbid)
      end
    end

    def initialize(mbid)
      @mbid   = mbid
      @events = nil
    end

    def upcoming_events
      return @events if @events

      events_hash = all("artists/mbid:#{@mbid}/events.json", 'event')
      @events = events_hash.map {|hash| Event.new(hash) }
    end

  end
end