require "spec_helper"
require "kmdata"
require "pry"

describe KMData do
  describe 'endpoint' do
    it 'returns the endpoint' do
      KMData::ENDPOINT.should eq('kmdata.osu.edu')
    end
  end

  describe 'path_with_params' do
    it 'appends the params to the path' do
      KMData.send(:path_with_params, 'people', { last_name: "Decot", first_name: "Kyle" }).should eq('people?last_name=Decot&first_name=Kyle')
    end
  end

  describe 'http' do
    it 'returns a Net::HTTP object' do
      KMData.send(:http).should be_an_instance_of(Net::HTTP)
    end
  end

  describe 'fetch' do
    it 'returns a Net::HTTPResponse object' do
      response = Net::HTTPResponse.new '', '', ''
      Net::HTTP.any_instance.stub(:request).with(anything).and_return(response)
      KMData.send(:fetch, '/api/terms.json').should be_an_instance_of(response.class)
    end
  end

  describe 'get' do
    it 'returns an array of terms' do
      json = File.read(File.join('spec', 'fixtures', 'terms.json'))
      response = double()
      response.stub!(:code) { "200" }
      response.stub!(:body) { json }

      KMData.stub!(:path_with_params).with("/api/terms.json", {})
      KMData.stub!(:fetch).with(anything).and_return(response)
      KMData.get('terms').should == KMData.send(:process, JSON.parse(json))
    end
  end
end
