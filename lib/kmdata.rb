%w[kmdata/version net/http json ostruct].each { |f| require f }

module KMData
  ENDPOINT = "kmdata.osu.edu"

  def self.get(path, params = {})
    path = "/api/#{path}.json?#{URI.encode_www_form(params)}"
    response = request(path)
    process(JSON.parse(response.body)) if response.code == "200"
  rescue Exception => exception
  end

  private

  def self.request(path)
    http.request(Net::HTTP::Get.new(path))
  end

  def self.http
    @http ||= begin
      http = Net::HTTP.new(ENDPOINT, 443)
      http.use_ssl = true
      http
    end
  end

  def self.process(json)
    if json.is_a? Array
      json.map { |element| process(element) }
    elsif json.is_a? Hash
      OpenStruct.new(Hash[json.map { |key, value| [key, process(value)] }])
    else
      json
    end
  end
end
