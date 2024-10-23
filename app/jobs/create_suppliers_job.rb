class CreateSuppliersJob < ApplicationJob
  queue_as :default

  def perform()
    response = Faraday.get('https://repnota1000.blu.com.br/api/v1/suppliers?per_page=100')
    total_pages = JSON.parse(response.body)['total_pages']

    (1..total_pages).each do |page|
      url = "https://repnota1000.blu.com.br/api/v1/suppliers?page=#{page}&per_page=100"
      page_response = Faraday.get(url)
      suppliers = JSON.parse(page_response.body)['suppliers']

      suppliers.each do |supplier|
        local_supplier = Supplier.find_by(cnpj: supplier['cpf_cnpj'])

        next if local_supplier

        local_supplier = Supplier.create(name: supplier['name'], cnpj: supplier['cpf_cnpj'], slug: supplier['slug'])

        supplier['departments'].each do |department|
          category = Category.create_with(name: department['name']).find_or_create_by(slug: department['slug'])
          local_supplier.categories << category
        end

        supplier['positions'].each do |position|
          state = State.create_with(name: position['name'], uf: position['uf'])
                       .find_or_create_by(slug: position['slug'])
          local_supplier.states << state
        end
      end
    end
  end
end
