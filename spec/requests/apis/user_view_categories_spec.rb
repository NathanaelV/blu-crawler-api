require 'rails_helper'

describe 'Category API' do
  context 'GET /api/v1/categories' do
    it 'success' do
      category = Category.create!(name: 'Colchões')
      category_second = Category.create!(name: 'Calçados')

      get '/api/v1/categories'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.first['id']).to eq category.id
      expect(json_response.first['name']).to eq category.name
      expect(json_response.first.keys).not_to include 'created_at'
      expect(json_response.first.keys).not_to include 'updated_at'

      expect(json_response.last['id']).to eq category_second.id
      expect(json_response.last['name']).to eq category_second.name
      expect(json_response.last.keys).not_to include 'created_at'
      expect(json_response.last.keys).not_to include 'updated_at'
    end
  end
end
