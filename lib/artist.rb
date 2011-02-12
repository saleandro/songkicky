require 'json_api'

module Songkicky
  class Artist
    include JsonApi

    attr_accessor :name, :mbids

    class << self
      def find_by_mbid(mbid)
        raise Error.new("MusicBrainz id is blank") if mbid.nil? || mbid.strip == ''

        Artist.new({'identifier' => ['mbid' => mbid]})
      end
     end

    def initialize(hash)
      @mbids  = (hash['identifier']||[]).map {|id| id['mbid']}
      @name   = hash['displayName']
      @upcoming_events = nil
    end

    def upcoming_events
      return @upcoming_events if @upcoming_events

      events_hash = all("artists/mbid:#{@mbids.first}/events.json", 'event')
      @upcoming_events = events_hash.map {|hash| Event.new(hash) }
    end

  end
end