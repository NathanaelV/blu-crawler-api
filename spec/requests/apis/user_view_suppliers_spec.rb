require 'rails_helper'

describe 'Suppliers API' do
  context 'GET /api/v1/suppliers' do
    it 'success' do
      category = Category.create!(name: 'Bicicletas')
      supplier = Supplier.create!(name: 'Caloi', category:)
      states = []
      states << State.create!(name: 'Todo o Brasil')
      supplier.states = states

      category_second = Category.create!(name: 'Eletroeletrônicos')
      supplier_second = Supplier.create!(name: 'GRUPO PDL - POSITIVO', category:)
      states_second = []
      states_second << State.create!(name: 'AC')
      states_second << State.create!(name: 'AM')
      states_second << State.create!(name: 'TO')
      supplier_second.states = states_second

      get '/api/v1/suppliers'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.first['id']).to eq supplier.id
      expect(json_response.first['name']).to eq supplier.name
      expect(json_response.first['category']).to eq category.as_json(except: %i[created_at updated_at])
      expect(json_response.first['states']).to eq states.as_json(except: %i[created_at updated_at])
      expect(json_response.first.keys).not_to include 'created_at'
      expect(json_response.first.keys).not_to include 'updated_at'

      expect(json_response.last['id']).to eq supplier_second.id
      expect(json_response.last['name']).to eq supplier_second.name
      expect(json_response.last.keys).not_to include 'created_at'
      expect(json_response.last.keys).not_to include 'updated_at'
    end

    it 'return empty if there is no supplier' do
      get '/api/v1/suppliers'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'and raise internal error' do
      allow(Supplier).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/suppliers'

      expect(response).to have_http_status(500)
      expect(response.body).to eq '{"message":"500 - Problema do lado do servidor"}'.as_json
    end
  end

  context 'GET /api/v1/suppliers/:id' do
    it 'success' do
      category = Category.create!(name: 'Bicicletas')
      supplier = Supplier.create!(name: 'Caloi', category:)
      states = []
      states << State.create!(name: 'AM')
      states << State.create!(name: 'TO')
      supplier.states = states

      get "/api/v1/suppliers/#{supplier.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq supplier.id
      expect(json_response['name']).to eq supplier.name
      expect(json_response['category']).to eq category.as_json(except: %i[created_at updated_at])
      expect(json_response['states']).to eq states.as_json(except: %i[created_at updated_at])
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
    end

    it 'fail if supplier not found' do
      get '/api/v1/suppliers/777'

      expect(response.status).to eq 404
      expect(response.body).to eq '{"message":"404 - Elemento não encontrado"}'.as_json
    end

    it 'and raise internal error' do
      allow(Supplier).to receive(:find).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/suppliers/2'

      expect(response).to have_http_status(500)
      expect(response.body).to eq '{"message":"500 - Problema do lado do servidor"}'.as_json
    end
  end
end
