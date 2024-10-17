require 'rails_helper'

describe 'States API' do
  context 'GET /api/v1/states' do
    it 'success' do
      state = State.create!(name: 'BA')
      state_second = State.create!(name: 'GO')

      get '/api/v1/states'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.first['id']).to eq state.id
      expect(json_response.first['name']).to eq state.name
      expect(json_response.first.keys).not_to include 'created_at'
      expect(json_response.first.keys).not_to include 'updated_at'

      expect(json_response.last['id']).to eq state_second.id
      expect(json_response.last['name']).to eq state_second.name
      expect(json_response.last.keys).not_to include 'created_at'
      expect(json_response.last.keys).not_to include 'updated_at'
    end

    it 'return empty if there is no state' do
      get '/api/v1/states'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'and raise internal error' do
      allow(State).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/states'

      expect(response).to have_http_status(500)
      expect(response.body).to eq '{"message":"500 - Problema do lado do servidor"}'.as_json
    end
  end
end
