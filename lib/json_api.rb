require 'rubygems'
require 'open-uri'
require 'json'

module Songkicky
  module JsonApi

    def all(path, thing)
      things = []
      per_page = total = nil
      page = 0

      while !per_page || (page*per_page) < total
        json_page = json_data_from(append_to_path(path, "page=#{page+1}"))["resultsPage"]
        page      = json_page["page"]
        per_page  = json_page["perPage"]
        total     = json_page["totalEntries"]

        next unless json_page["results"][thing]

        things += json_page["results"][thing]
      end
      things
    end

    private

    def json_data_from(path)
      path = path[1..-1] if path[0,1] == '/'
      url = "#{api_root}#{append_to_path(path, api_key_query_string)}"
      JSON.parse(open(url).read)
    rescue URI::InvalidURIError
      return nil
    rescue OpenURI::HTTPError => e
      case e.message
        when /403/
          raise Songkicky::Error.new("Are you sure you set your Songkicky.apikey correctly? It's set to: '#{Songkicky.apikey}'")
        else
          raise e
      end
    end

    def append_to_path(path, query_string)
      sep = path && path.match(/\?/) ? '&' : '?'
      "#{path}#{sep}#{query_string}"
    end

    def api_key_query_string
      "apikey=#{Songkicky.apikey}"
    end

    def api_root
      'http://api.songkick.com/api/3.0/'
    end
  end
end
