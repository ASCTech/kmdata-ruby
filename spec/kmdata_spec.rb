require "spec_helper"
require "kmdata"

describe KMData do

  describe 'endpoint' do
    it 'returns the endpoint' do
      KMData.endpoint.should eq('kmdata.osu.edu')
    end
  end

  describe 'path_with_params' do
    it 'appends the params to the path' do
      KMData.send(:path_with_params, 'people', { last_name: "Decot", first_name: "Kyle" }).should eq('people?last_name=Decot&first_name=Kyle')
    end
  end

  describe 'http' do
    it 'returns a Net::HTTP object' do
      KMData.http.should be_an_instance_of(Net::HTTP)
    end
  end

end
