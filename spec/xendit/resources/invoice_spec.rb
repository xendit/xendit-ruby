# frozen_string_literal: true

require 'xendit/resources/invoice'

describe Xendit::Invoice do
  let(:invoice) do
    {
      'id' => '1273018302173',
      'external_id' => 'demo_147580196270',
      'user_id' => '12234238302171',
      'status' => 'PENDING',
      'merchant_name' => 'COMPANY ABC',
      'merchant_profile_picture_url' => 'dummy.png',
      'amount' => 10_000_000,
      'payer_email' => 'sample_email@xendit.co',
      'description' => 'Trip to Bali',
      'expiry_date' => '2021-02-13T17:53:06.980Z',
      'invoice_url' => 'https://checkout.xendit.co/web/1273018302173',
      'created' => '2021-02-09T17:53:07.102Z',
      'updated' => '2021-02-09T17:53:07.102Z',
      'currency' => 'IDR'
    }
  end

  describe '.create' do
    context 'given a complete invoice details' do
      let(:url) { 'v2/invoices' }
      let(:invoice_params) do
        {
          external_id: 'demo_147580196270',
          payer_email: 'sample_email@xendit.co',
          description: 'Trip to Bali',
          amount: 10_000_000
        }
      end
      let(:api_operation_response) do
        OpenStruct.new({
                         status: 200,
                         body: JSON.generate(invoice)
                       })
      end

      it 'should return the created invoice object' do
        allow(Xendit::APIOperations).to receive(:post).with(url, invoice_params).and_return(api_operation_response)

        result = described_class.create invoice_params
        expect(result).to eq(invoice)
      end
    end

    context 'given an incomplete invoice details' do
      let(:invalid_invoice_params) do
        {
          external_id: 'demo_147580196270',
          payer_email: 'sample_email@xendit.co'
        }
      end

      it 'should raise argument error' do
        expect(-> { described_class.create invalid_invoice_params }).
          to raise_error(ArgumentError)
      end
    end
  end

  describe '.get' do
    let(:url) { "v2/invoices/#{invoice['id']}" }
    let(:api_operation_response) do
      OpenStruct.new({
                       status: 200,
                       body: JSON.generate(invoice)
                     })
    end

    it 'should return a invoice object' do
      allow(Xendit::APIOperations).to receive(:get).with(url).and_return(api_operation_response)

      result = described_class.get invoice['id']
      expect(result).to eq(invoice)
    end
  end

  describe '.get_all' do
    let(:url) { 'v2/invoices' }
    let(:api_operation_response) do
      OpenStruct.new({
                       status: 200,
                       body: JSON.generate(invoice)
                     })
    end

    it 'should return invoice object(s)' do
      allow(Xendit::APIOperations).to receive(:get).with(url, nil).and_return(api_operation_response)

      result = described_class.get_all
      expect(result).to eq(invoice)
    end
  end

  describe '.expire!' do
    let(:url) { "invoices/#{invoice['id']}/expire!" }
    let(:expired_invoice) { invoice.clone.merge('status' => 'EXPIRED') }
    let(:api_operation_response) do
      OpenStruct.new({
                       status: 200,
                       body: JSON.generate(expired_invoice)
                     })
    end

    it 'should return the expired invoice object' do
      allow(Xendit::APIOperations).to receive(:post).with(url).and_return(api_operation_response)

      result = described_class.expire invoice['id']
      expect(result).to eq(expired_invoice)
    end
  end
end
