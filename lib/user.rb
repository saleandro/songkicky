require 'json_api'

module Songkicky
  class User
    include JsonApi

    class << self
      def find_by_username(username)
        raise Error.new("Username is blank") if username.nil? || username.strip == ''
        User.new(username)
      end
    end

    def initialize(username)
      @username = username
      @past_events = @upcoming_events = nil
    end

    def past_events
      return @past_events if @past_events

      events_hash = all("users/#{@username}/gigography.json", 'event')
      @past_events = events_hash.map {|hash| Event.new(hash) }
    end

    def upcoming_events
      return @upcoming_events if upcoming_events

      events_hash = all("users/#{@username}/calendar.json", 'event')
      @upcoming_events = events_hash.map {|hash| Event.new(hash) }
    end
  end
end