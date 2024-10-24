require 'rails_helper'

RSpec.describe Apis::FetchSuppliers, type: :api do
  describe '.fetch_first_page' do
    it 'successfully' do
      body_respoonse = {
        suppliers: [],
        total_pages: 5
      }
      request = stub_request(:get, 'https://repnota1000.blu.com.br/api/v1/suppliers?per_page=100')
                  .to_return(body: body_respoonse.to_json)

      api_response = Apis::FetchSuppliers.new.fetch_first_page

      expect(request).to have_been_requested
      expect(api_response).to eq body_respoonse
    end
  end

  describe '.fetch_other_pages' do
    it 'successfully' do
      current_page = 3
      body_respoonse = {
        suppliers: [],
        total_pages: 5
      }
      request = stub_request(:get, 'https://repnota1000.blu.com.br/api/v1/suppliers?page=3&per_page=100')
                  .to_return(body: body_respoonse.to_json)

      api_response = Apis::FetchSuppliers.new.fetch_other_pages(current_page)

      expect(request).to have_been_requested
      expect(api_response).to eq body_respoonse
    end
  end
end
