require 'rails_helper'
RSpec.describe CrawlerSuppliersJob, type: :job do
  it 'All country without sub category' do
    supplier_url = 'https://fornecedores.blu.com.br/segmento/bicicletas/caloi-norte-sa'

    CrawlerSuppliersJob.perform_now(supplier_url)
    
    expect(Supplier.first.name).to eq 'Caloi'
    expect(Supplier.first.url).to eq supplier_url
    expect(Supplier.first.category_id).to eq 1
    expect(Supplier.first.states.first.name).to eq 'Todo o Brasil'
    expect(Supplier.first.states.count).to eq 1
  end

  it 'Only one state with sub category' do
    Category.create!(name: 'Bicicletas')
    supplier_url = 'https://fornecedores.blu.com.br/segmento/colchoes/1-click-interiores'

    CrawlerSuppliersJob.perform_now(supplier_url)
    
    expect(Supplier.first.name).to eq '1 Click Interiores'
    expect(Supplier.first.url).to eq supplier_url
    expect(Supplier.first.category_id).to eq 2
    expect(Supplier.first.states.first.name).to eq 'GO'
    expect(Supplier.first.states.count).to eq 1
  end

  it 'More than one state with sub category' do
    Category.create!(name: 'Bicicletas')
    category = Category.create!(name: 'Colchões')
    supplier_url = 'https://fornecedores.blu.com.br/segmento/colchoes/2m-industria-de-moveis-ltda'

    CrawlerSuppliersJob.perform_now(supplier_url)

    expect(Supplier.first.name).to eq '2M Móveis'
    expect(Supplier.first.url).to eq supplier_url
    expect(Supplier.first.category_id).to eq category.id
    expect(Supplier.first.states.first.name).to eq 'ES'
    expect(Supplier.first.states.last.name).to eq 'RJ'
    expect(Supplier.first.states.count).to eq 4
  end

  it 'Without state and with sub category' do
    supplier_url = 'https://fornecedores.blu.com.br/segmento/calcados/tess'

    CrawlerSuppliersJob.perform_now(supplier_url)
    
    expect(Supplier.first.name).to eq 'Kenner'
    expect(Supplier.first.url).to eq supplier_url
    expect(Supplier.first.category_id).to eq 1
    expect(Supplier.first.states.first.name).to eq 'Sem região cadastrada'
  end
end
