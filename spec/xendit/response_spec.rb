# frozen_string_literal: true

require 'xendit/response'

describe Xendit::Response do
  describe '.create_connection' do
    context 'given no response' do
      it 'should raise argument error' do
        expect(-> { described_class.handle_error_response }).
          to raise_error(ArgumentError)
      end
    end

    context 'given an invalid response' do
      let(:invalid_response) do
        OpenStruct.new({
                         invalid_status: 200,
                         invalid_body: '{"id":"1273018302173","status":"PENDING"}'
                       })
      end

      it 'should raise argument error' do
        expect(-> { described_class.handle_error_response(invalid_response) }).
          to raise_error(ArgumentError)
      end
    end

    context 'given an invalid body response' do
      let(:invalid_body_response) do
        OpenStruct.new({
                         status: 400,
                         body: 'this is not a json'
                       })
      end

      it 'should raise API error' do
        expect(-> { described_class.handle_error_response(invalid_body_response) }).
          to raise_error(Xendit::APIError)
      end
    end

    context 'given an error response' do
      let(:error_response) do
        OpenStruct.new({
                         status: 400,
                         body: '{"error_code":"INVALID_API_KEY","message":"API key is not authorized for this API service"}'
                       })
      end

      it 'should raise API error' do
        expect(-> { described_class.handle_error_response(error_response) }).
          to raise_error(Xendit::APIError)
      end
    end

    context 'given a valid response' do
      let(:valid_response) do
        OpenStruct.new({
                         status: 200,
                         body: '{"id":"1273018302173","status":"PENDING"}'
                       })
      end

      it 'should not raise API error' do
        expect(-> { described_class.handle_error_response(valid_response) }).
          not_to raise_error(Xendit::APIError)
      end
    end
  end
end
