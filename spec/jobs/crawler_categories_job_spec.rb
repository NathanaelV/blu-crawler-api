require 'rails_helper'
RSpec.describe CrawlerCategoriesJob, type: :job do
  it 'Active Jobs' do
    collect_suppliers_urls_job = spy('CollectSuppliersUrlsJob')
    stub_const 'CollectSuppliersUrlsJob', collect_suppliers_urls_job

    CrawlerCategoriesJob.perform_now()
    
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/bicicletas')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/calcados')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/colchoes')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/drogarias')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/eletro')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/entretenimento')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/loja-de-artigos-em-geral')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/materia-prima')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/moveis')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/otica')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/pecas-servicos-automotivos')
    expect(CollectSuppliersUrlsJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/vestuario-em-geral')
    expect(Category.count).to eq 12
  end

  it 'Only creates categories that do not exist' do
    Category.create!(name: 'Eventos, Bebidas e Alimentos')
    Category.create!(name: 'Colchões')
    Category.create!(name: 'Peças / Serviços Automotivos')

    CrawlerCategoriesJob.perform_now()

    expect(Category.count).to eq 12
  end
end
