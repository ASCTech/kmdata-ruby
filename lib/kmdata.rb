require "kmdata/version"
require 'net/http'
require 'json'
require 'ostruct'

module KMData
  class << self

    def endpoint
      "kmdata.osu.edu"
    end

    def get(path, params = {})
      path = path_with_params("/api/#{path}.json", params)
      response = http.request(Net::HTTP::Get.new(path))
      process(JSON.parse(response.body))
    rescue Exception => exception
      return false
    end

    private

    def http
      @http ||= begin
        http = Net::HTTP.new(endpoint, 443)
        http.use_ssl = true
        http
      end
    end

    # Takes JSON and converts it into a OpenStruct representation. This method
    # is recursive so it's somewhat hard to tell what's going on sometimes...
    def process(json)

      # If the current json is an array then we need to loop through each
      # element and process it and add it to the newly created array

      if json.is_a? Array
        result = json.map do |element|
          process(element)
        end

      # If the current json is a hash then we need to created a new hash by
      # looping over each of it's keys and processing the values

      elsif json.is_a? Hash
        json = Hash[json.map{ |key, value| [key,process(value)] }]
        result = OpenStruct.new(json)

      # The current json is some kind of primitive so there's nothing to do in
      # this case so we'll just return it

      else
        result = json
      end

      result
    end

    def path_with_params(path, params)
      [path, URI.encode_www_form(params)].join('?')
    end

  end
end
