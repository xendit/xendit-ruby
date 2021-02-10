# frozen_string_literal: true

require 'xendit/api_operations'

describe Xendit::ApiOperations do
  describe '.create_connection' do
    it 'should returns a connection object' do
      conn = described_class.send(:create_connection)
      expect(conn).to be_an_instance_of(Faraday::Connection)
    end
  end

  describe '.get' do
    context 'given a GET one request' do
      let(:url) { 'invoices/1273018302173' }
      let(:response) do
        OpenStruct.new({
                         status: 200,
                         body: '{"id":"1273018302173","status":"PENDING"}'
                       })
      end

      it 'should return the object' do
        allow_any_instance_of(Faraday::Connection).to receive(:get).with(url, nil).and_return(response)

        result = described_class.get url
        expect(result).to eq(response)
      end
    end

    context 'given a GET all request' do
      let(:url) { 'invoices' }
      let(:filter_params) do
        {
          limit: 2
        }
      end
      let(:response) do
        OpenStruct.new({
                         status: 200,
                         body: '[{"id":"1273018302173","status":"PENDING"},{"id":"1273018302174","status":"PENDING"}]'
                       })
      end

      it 'should return objects based on filtered requirements' do
        allow_any_instance_of(Faraday::Connection).to receive(:get).with(url, filter_params).and_return(response)

        result = described_class.get url, filter_params
        expect(result).to eq(response)
      end
    end
  end

  describe '.post' do
    context 'given a POST request' do
      let(:url) { 'invoices' }
      let(:post_params) do
        {
          status: 'PENDING'
        }
      end
      let(:response) do
        OpenStruct.new({
                         status: 200,
                         body: '{"id":"1273018302173","status":"PENDING"'
                       })
      end

      it 'should return the created object' do
        allow_any_instance_of(Faraday::Connection).to receive(:post).with(url, JSON.generate(post_params)).and_return(response)

        result = described_class.post url, **post_params
        expect(result).to eq(response)
      end
    end
  end
end
