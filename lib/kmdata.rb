require "kmdata/version"
require "net/http"
require "json"
require "ostruct"
require "recursive-open-struct"

module KMData
  class << self

    def endpoint
      "kmdata.osu.edu"
    end

    def get(path, params = {})
      path = path_with_params("/api/#{path}.json", params)

      response = http.request(Net::HTTP::Get.new(path))

      if response.body
        json = JSON.parse(response.body)

        if json.is_a? Array
          json.map do |j|
            RecursiveOpenStruct.new(j, recurse_over_arrays: true)
          end
        else
          RecursiveOpenStruct.new(json, recurse_over_arrays: true)
        end
      end
    end

    def http
      @http ||= begin
        http = Net::HTTP.new(endpoint, 443)
        http.use_ssl = true
        http
      end
    end

    protected

    def path_with_params(path, params)
      encoded_params = URI.encode_www_form(params)
      [path, encoded_params].join("?")
    end
  end
end
