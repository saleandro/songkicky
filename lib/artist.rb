require 'json_api'

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
      @upcoming_events = nil
    end

    def upcoming_events
      return @upcoming_events if @upcoming_events

      events_hash = all("artists/mbid:#{@mbid}/events.json", 'event')
      @upcoming_events = events_hash.map {|hash| Event.new(hash) }
    end

  end
end