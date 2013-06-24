require "spec_helper"
require "kmdata"

describe KMData do
  describe '.endpoint' do
    subject { KMData::ENDPOINT }
    it { should eq "kmdata.osu.edu" }
  end

  describe '.path_with_params' do
    subject { KMData.send(:path_with_params, 'people', { last_name: "Decot", first_name: "Kyle" }) }
    it 'appends the params to the path' do
      should eq('people?last_name=Decot&first_name=Kyle')
    end
  end

  describe '.http' do
    subject { KMData.send(:http) }
    it { should respond_to(:request) }
  end

  describe '.request' do
    subject { KMData.send(:request, '/api/terms.json') }
    before :each do
      response = Net::HTTPResponse.new('', '', '')
      Net::HTTP.any_instance.stub(:request).with(anything).and_return(response)
    end
    it { should respond_to(:body) }
    it { should respond_to(:code) }
  end

  describe '.get' do
    it 'returns an array of terms' do
      json = File.read(File.join('spec', 'fixtures', 'terms.json'))
      response = double()
      response.stub!(:code) { "200" }
      response.stub!(:body) { json }

      KMData.stub!(:path_with_params).with("/api/terms.json", {})
      KMData.stub!(:request).with(anything).and_return(response)
      KMData.get('terms').should == KMData.send(:process, JSON.parse(json))
    end
  end
end
