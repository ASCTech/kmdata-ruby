require "spec_helper"
require "kmdata"
require "pry"

describe KMData do
  describe '.get' do
    let(:json) { File.read(File.join('spec', 'fixtures', 'terms.json')) }
    it 'returns an array of terms' do
      response = double()
      response.stub!(:code) { "200" }
      response.stub!(:body) { json }

      KMData.stub!(:path_with_params).with("/api/terms.json", {})
      KMData.stub!(:request).with(anything).and_return(response)
      KMData.get('terms').should == KMData.send(:process, JSON.parse(json))
    end
  end

  describe '.process' do
    let(:data) { [1, 2, { foo: 'bar', baz: true }] }
    subject { KMData.send :process, data }
    it 'transforms json' do
      subject[0].should eql 1
      subject[2].foo.should eql 'bar'
      subject[2].baz.should be_true
    end
  end

  describe '.http' do
    subject { KMData.send :http }
    it { should respond_to(:request) }
  end

  describe '.request' do
    subject { KMData.send :request, '/api/terms.json' }
    before :each do
      response = Net::HTTPResponse.new('', '', '')
      Net::HTTP.any_instance.stub(:request).with(anything).and_return(response)
    end
    it { should respond_to(:body) }
    it { should respond_to(:code) }
  end
end
