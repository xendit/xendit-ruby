# frozen_string_literal: true

require 'xendit/response'

describe Xendit::Response do
  describe '.create_connection' do
    let(:error_response) do
      OpenStruct.new({
                       status: 400,
                       body: '{"error_code":"INVALID_API_KEY","message":"API key is not authorized for this API service"}'
                     })
    end

    let(:valid_response) do
      OpenStruct.new({
                       status: 200,
                       body: '{"id":"1273018302173","status":"PENDING"}'
                     })
    end

    context 'given a valid response' do
      it 'should not raise API error' do
        expect(-> { described_class.handle_error_response(valid_response) }).
          not_to raise_error(Xendit::APIError)
      end
    end

    context 'given an error response' do
      it 'should raise API error' do
        expect(-> { described_class.handle_error_response(error_response) }).
          to raise_error(Xendit::APIError)
      end
    end
  end
end
