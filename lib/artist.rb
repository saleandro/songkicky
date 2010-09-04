require 'json_api'

module Songkicky
  class Artist
    include JsonApi

    attr_accessor :name, :mbid

    class << self
      def find_by_mbid(mbid)
        raise Error.new("MusicBrainz id is blank") if mbid.nil? || mbid.strip == ''

        Artist.new(mbid)
      end

      def find_by_name(name)
        raise Error.new("Name is blank") if name.nil? || name.strip == ''

        a = Artist.new(nil)
        a.name = name
        a
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