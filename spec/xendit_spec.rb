# frozen_string_literal: true

require 'xendit'

describe Xendit do
  after do
    Xendit.api_key = nil
    Xendit.base_url = nil
  end

  describe 'API key' do
    let(:api_key) { 'this_is_my_api_key' }

    context 'given no API key provided' do
      it 'should return nil' do
        expect(described_class.api_key).to be_nil
      end
    end

    context 'given an API key provided' do
      it 'should return the given API key' do
        described_class.api_key = api_key
        expect(Xendit.api_key).to eq(api_key)
      end
    end
  end

  describe 'API base URL' do
    let(:default_base_url) { 'https://api.xendit.co/' }
    let(:base_url) { 'https://api.xendit.staging.co/' }

    context 'given no API URL provided' do
      it 'should return the default base_url' do
        expect(described_class.base_url).to eq(default_base_url)
      end
    end

    context 'given an API URL' do
      it 'should return the given base_url' do
        Xendit.base_url = base_url
        expect(described_class.base_url).to eq(base_url)
      end
    end
  end
end
