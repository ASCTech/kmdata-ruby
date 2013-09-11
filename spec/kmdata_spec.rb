require "spec_helper"
require "kmdata"

describe KMData do
  describe '.get' do
    let(:json) { File.read(File.join('spec', 'fixtures', 'terms.json')) }

    context 'success' do
      it 'returns an array of terms' do
        response = double()
        response.stub(:code) { "200" }
        response.stub(:body) { json }

        KMData.stub(:path_with_params).with("/api/terms.json", {}).and_return("/api/terms.json")
        KMData.stub(:request).with(anything()).and_return(response)
        KMData.get('terms').should_not be_nil
      end
    end

    context 'failure' do
      it 'returns nil' do
        response = double()
        response.stub(:code) { "500" }
        response.stub(:body) { nil }

        KMData.stub(:path_with_params).with("/api/terms.json", {}).and_return("/api/terms.json")
        KMData.http.stub(:request).with(anything()).and_return(response)
        KMData.get('terms').should be_nil
      end
    end

  end

  describe '.http' do
    subject { KMData.send :http }
    it { should respond_to(:request) }
  end
end
