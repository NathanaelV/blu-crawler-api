require 'apis/fetch_suppliers'

class CreateSuppliersJob < ApplicationJob
  queue_as :default

  def perform()
    first_response = Apis::FetchSuppliers.new.fetch_first_page
    total_pages = first_response[:total_pages]
    create_suppliers(first_response[:suppliers])

    return if total_pages == 1

    (2..total_pages).each do |page|
      other_response = Apis::FetchSuppliers.new.fetch_other_pages(page)
      suppliers = other_response[:suppliers]

      create_suppliers(suppliers)
    end
  end

  private

  def create_suppliers(suppliers)
    suppliers.each do |supplier|
      local_supplier = Supplier.find_by(cnpj: supplier[:cpf_cnpj])

      next if local_supplier

      local_supplier = Supplier.create(name: supplier[:name], cnpj: supplier[:cpf_cnpj], slug: supplier[:slug])

      supplier[:departments].each do |department|
        category = Category.create_with(name: department[:name]).find_or_create_by(slug: department[:slug])
        local_supplier.categories << category
      end

      supplier[:positions].each do |position|
        state = State.create_with(name: position[:name], uf: position[:uf])
                     .find_or_create_by(slug: position[:slug])
        local_supplier.states << state
      end
    end
  end
end
