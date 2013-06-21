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
    end

    def http
      @http ||= begin
        http = Net::HTTP.new(endpoint, 443)
        http.use_ssl = true
        http
      end
    end

    protected

    def process(json)
      if json.is_a? Array
        result = json.map do |element|
          process(element)
        end
      elsif json.is_a? Hash
        json = Hash[json.map{ |key, value| [key,process(value)] }]
        result = OpenStruct.new(json)
      else
        # Some kind of string, float, or other primitive..no need to do anything.
        result = json
      end
      result
    end

    def path_with_params(path, params)
      encoded_params = URI.encode_www_form(params)
      [path, encoded_params].join('?')
    end

  end
end
