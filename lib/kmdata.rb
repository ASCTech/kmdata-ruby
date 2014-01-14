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

    def get(endpoint, params = {})

      json_results = []

      1.step(by: 1) do |n|
        params[:page] = n
        path = path_with_params("/api/#{endpoint}.json", params)
        response = http.request(Net::HTTP::Get.new(path))

        if response.body
          json = JSON.parse(response.body)
          break if json.empty?

          if json.is_a? Array
            json.map do |j|
              json_results << RecursiveOpenStruct.new(j, recurse_over_arrays: true)
            end
          else
            json_results << RecursiveOpenStruct.new(json, recurse_over_arrays: true)
          end
        end

      end
      json_results.size == 1 ? json_results.first : json_results
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
