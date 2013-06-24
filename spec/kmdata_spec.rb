require "spec_helper"
require "kmdata"

describe KMData do
  describe '.get' do
    let(:json) { File.read(File.join('spec', 'fixtures', 'terms.json')) }

    context 'success' do
      it 'returns an array of terms' do
        response = double()
        response.stub!(:code) { "200" }
        response.stub!(:body) { json }

        KMData.stub!(:path_with_params).with("/api/terms.json", {})
        KMData.stub!(:request).with(anything).and_return(response)
        KMData.get('terms').should == KMData.send(:process, JSON.parse(json))
      end
    end

    context 'failure' do
      it 'returns nil' do
        response = double()
        response.stub!(:code) { "500" }
        response.stub!(:body) { nil }

        KMData.stub!(:path_with_params).with("/api/terms.json", {})
        KMData.stub!(:request).with(anything).and_return(response)
        KMData.get('terms').should be_nil
      end
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
    let(:response) do
      response = double()
      response.stub!(:body).and_return('')
      response.stub!(:code).and_return('200')
      response
    end
    subject { KMData.send(:request, '/api/terms.json') }
    it 'should respond to body and code' do
      http = double()
      http.stub!(:request).and_return(response)
      KMData.stub!(:http).and_return(http)

      subject.should respond_to(:body, :code)
    end
  end
end
