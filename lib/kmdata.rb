%w[kmdata/version net/http json ostruct].each { |f| require f }

module KMData
  ENDPOINT = "kmdata.osu.edu"
  class << self

    def get(path, params = {})
      path = path_with_params("/api/#{path}.json", params)
      response = http.request(Net::HTTP::Get.new(path))
      process(JSON.parse(response.body)) if response.code == "200"
    rescue Exception => exception
    end

    private

    def http
      @http ||= begin
        http = Net::HTTP.new(ENDPOINT, 443)
        http.use_ssl = true
        http
      end
    end

    def process(json)
      if json.is_a? Array
        json.map { |element| process(element) }
      elsif json.is_a? Hash
        OpenStruct.new(Hash[json.map { |key, value| [key, process(value)] }])
      else
        json
      end
    end

    def path_with_params(path, params = {})
      [path, URI.encode_www_form(params)].join("?")
    end
  end
end
