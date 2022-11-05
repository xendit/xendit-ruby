# frozen_string_literal: true

require 'xendit/resources/refund'

describe Xendit::Refund do
  let(:refund) do
    {
      "id": "rfd-69e77490-d2cc-4bf3-8319-e064e121db93",
      "payment_id": "pr-d5fe8554-fbcd-42b3-956d-867376550ed9",
      "invoice_id": "",
      "amount": 3000,
      "payment_method_type": "CARD",
      "channel_code": "",
      "currency": "PHP",
      "status": "SUCCEEDED",
      "reason": "CANCELLATION",
      "reference_id": "9d9c04a9-55c8-4eea-8b09-4109ac10b7f0",
      "failure_code": null,
      "refund_fee_amount": null,
      "created": "2022-09-29T03:37:07.06648896Z",
      "updated": "2022-09-29T03:37:07.06648906Z",
      "metadata": null
  }
  end

  describe '.create' do
    context 'given a complete refund details' do
      let(:url) { '/refunds' }
      let(:refund_params) do
        {
          invoice_id: '63651bbbb1d95a2e306aeb5e',
          reference_id: 'Any Reference',
          reason: 'CANCELLATION',
          currency: 'PHP',
          amount: 10_000,
        }
      end
      let(:api_operation_response) do
        OpenStruct.new({
                         status: 200,
                         body: JSON.generate(refund)
                       })
      end

      it 'should return the created refund object' do
        allow(Xendit::APIOperations).to receive(:post).with(url, refund_params).and_return(api_operation_response)

        result = described_class.create refund_params
        expect(result).to eq(refund)
      end
    end

    context 'given an incomplete refund details' do
      let(:invalid_refund_params) do
        {
          invoice_id: '63651bbbb1d95a2e306aeb5e'
          currency: 'PHP',
          readon: 'CANCELLATION'
        }
      end

      it 'should raise argument error' do
        expect(-> { described_class.create invalid_refund_params }).
          to raise_error(ArgumentError)
      end
    end
  end

  describe '.get' do
    let(:url) { "/refunds/#{refund['id']}" }
    let(:api_operation_response) do
      OpenStruct.new({
                       status: 200,
                       body: JSON.generate(refund)
                     })
    end

    it 'should return a refund object' do
      allow(Xendit::APIOperations).to receive(:get).with(url).and_return(api_operation_response)

      result = described_class.get refund['id']
      expect(result).to eq(refund)
    end
  end

  describe '.get_all' do
    let(:url) { '/refunds' }
    let(:api_operation_response) do
      OpenStruct.new({
                       status: 200,
                       body: JSON.generate(refund)
                     })
    end

    it 'should return refund object(s)' do
      allow(Xendit::APIOperations).to receive(:get).with(url, nil).and_return(api_operation_response)

      result = described_class.get_all
      expect(result).to eq(refund)
    end
  end
end
