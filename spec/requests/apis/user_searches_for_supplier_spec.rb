require 'rails_helper'

describe 'Suppliers API' do
  context 'GET /api/v1/suppliers/search?name' do
    it 'success' do
      first_sup = Supplier.create!(name: 'Caloi', slug: 'caloi', cnpj: '35806380000100')
      second_sup = Supplier.create!(name: 'Caloi Brasil', slug: 'caloi-brasil', cnpj: '35806380000120')
      third_sup = Supplier.create!(name: 'Groove', slug: 'groove', cnpj: '35806380000130')
      category = Category.create!(name: 'Bicicletas')
      state = State.create!(name: 'Minas Gerais', uf: 'MG')
      state.suppliers << first_sup
      state.suppliers << second_sup
      state.suppliers << third_sup
      category.suppliers << first_sup
      category.suppliers << second_sup
      category.suppliers << third_sup

      get '/api/v1/suppliers/search?name=cal'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq 2
      expect(json_response.first['name']).to eq 'Caloi'
      expect(json_response.second['name']).to eq 'Caloi Brasil'
    end

    it 'using underscore' do
      category = Category.create!(name: 'Bicicletas')
      state = State.create!(name: 'Todo o Brasil')
      first_sup = Supplier.create!(name: 'Caloi')
      second_sup = Supplier.create!(name: 'Caloi Brasil')
      state.suppliers << first_sup
      state.suppliers << second_sup
      category.suppliers << first_sup
      category.suppliers << second_sup

      get '/api/v1/suppliers/search?name=caloi b'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq 1
      expect(json_response.first['name']).to eq 'Caloi Brasil'
    end

    it 'name not found' do
      category = Category.create!(name: 'Bicicletas')
      state = State.create!(name: 'Todo o Brasil')
      supplier = Supplier.create!(name: 'Groove')
      state.suppliers << supplier
      supplier.categories << category

      get '/api/v1/suppliers/search?name=cal'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end

  context 'GET /api/v1/suppliers/search?categoria_id&state_id&operator' do
    context 'without operator' do
      it 'success' do
        category = Category.create!(name: 'Bicicletas')
        category_second = Category.create!(name: 'Eletrônicos')
        category.suppliers << first_sup = Supplier.create!(name: 'Caloi')
        category_second.suppliers << second_sup = Supplier.create!(name: 'Wanke')
        category_second.suppliers << third_sup = Supplier.create!(name: 'Braslar')
        category.suppliers << fourth_sup = Supplier.create!(name: 'Groove')
        
        state = State.create!(name: 'Todo o Brasil')
        bahia = State.create!(name: 'BA')
        state.suppliers << first_sup
        state.suppliers << second_sup
        bahia.suppliers << third_sup
        bahia.suppliers << fourth_sup

        get "/api/v1/suppliers/search?category_id=#{category.id}&state_id=#{bahia.id}"

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq 3
        expect(json_response.first['name']).to eq 'Caloi'
        expect(json_response.second['name']).to eq 'Braslar'
        expect(json_response.third['name']).to eq 'Groove'
      end

      it 'with only category_id' do
        category = Category.create!(name: 'Bicicletas')
        category_second = Category.create!(name: 'Eletrônicos')
        category.suppliers << first_sup = Supplier.create!(name: 'Caloi')
        category_second.suppliers << second_sup = Supplier.create!(name: 'Wanke')
        category_second.suppliers << third_sup = Supplier.create!(name: 'Braslar')
        category.suppliers << fourth_sup = Supplier.create!(name: 'Groove')
        
        state = State.create!(name: 'Todo o Brasil')
        bahia = State.create!(name: 'BA')
        state.suppliers << first_sup
        state.suppliers << second_sup
        bahia.suppliers << third_sup
        bahia.suppliers << fourth_sup

        get "/api/v1/suppliers/search?category_id=#{category.id}"

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq 2
        expect(json_response.first['name']).to eq 'Caloi'
        expect(json_response.second['name']).to eq 'Groove'
      end
  
      it 'with only state_id' do
        category = Category.create!(name: 'Bicicletas')
        category_second = Category.create!(name: 'Eletrônicos')
        category.suppliers << first_sup = Supplier.create!(name: 'Caloi')
        category_second.suppliers << second_sup = Supplier.create!(name: 'Wanke')
        category_second.suppliers << third_sup = Supplier.create!(name: 'Braslar')
        category.suppliers << fourth_sup = Supplier.create!(name: 'Groove')
        
        state = State.create!(name: 'Todo o Brasil')
        bahia = State.create!(name: 'BA')
        state.suppliers << first_sup
        state.suppliers << second_sup
        bahia.suppliers << third_sup
        bahia.suppliers << fourth_sup
  
        get "/api/v1/suppliers/search?state_id=#{bahia.id}"
  
        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq 2
        expect(json_response.first['name']).to eq 'Braslar'
        expect(json_response.second['name']).to eq 'Groove'
      end

      it 'not found' do
        category = Category.create!(name: 'Bicicletas')
        category_second = Category.create!(name: 'Eletrônicos')
        category.suppliers << first_sup = Supplier.create!(name: 'Caloi')
        category_second.suppliers << second_sup = Supplier.create!(name: 'Wanke')
        category_second.suppliers << third_sup = Supplier.create!(name: 'Braslar')
        category.suppliers << fourth_sup = Supplier.create!(name: 'Groove')
        
        state = State.create!(name: 'Todo o Brasil')
        bahia = State.create!(name: 'BA')
        state.suppliers << first_sup
        state.suppliers << second_sup
        bahia.suppliers << third_sup
        bahia.suppliers << fourth_sup

        get "/api/v1/suppliers/search?category_id=777&state_id=777"

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response).to eq []
      end
    end

    context 'using operator AND' do
      it 'success' do
        category = Category.create!(name: 'Bicicletas')
        category_second = Category.create!(name: 'Eletrônicos')
        category.suppliers << first_sup = Supplier.create!(name: 'Caloi')
        category_second.suppliers << second_sup = Supplier.create!(name: 'Wanke')
        category_second.suppliers << third_sup = Supplier.create!(name: 'Braslar')
        category.suppliers << fourth_sup = Supplier.create!(name: 'Groove')
        
        state = State.create!(name: 'Todo o Brasil')
        bahia = State.create!(name: 'BA')
        state.suppliers << first_sup
        state.suppliers << second_sup
        bahia.suppliers << third_sup
        bahia.suppliers << fourth_sup
  
        get "/api/v1/suppliers/search?category_id=#{category.id}&state_id=#{bahia.id}&operator=And"
  
        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq 1
        expect(json_response.first['name']).to eq 'Groove'
      end

      it 'not found' do
        category = Category.create!(name: 'Bicicletas')
        category_second = Category.create!(name: 'Eletrônicos')
        category.suppliers << first_sup = Supplier.create!(name: 'Caloi')
        category_second.suppliers << second_sup = Supplier.create!(name: 'Wanke')
        category_second.suppliers << third_sup = Supplier.create!(name: 'Braslar')
        category.suppliers << fourth_sup = Supplier.create!(name: 'Groove')
        
        state = State.create!(name: 'Todo o Brasil')
        bahia = State.create!(name: 'BA')
        state.suppliers << first_sup
        state.suppliers << second_sup
        bahia.suppliers << third_sup
        bahia.suppliers << fourth_sup

        get "/api/v1/suppliers/search?category_id=777&state_id=777&operator=and"

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response).to eq []
      end
    end
  end
end
