require 'rails_helper'
RSpec.describe CrawlerCategoriesJob, type: :job do
  it 'Active Jobs' do
    collect_suppliers_urls_job = spy('CrawlerSuppliersJob')
    stub_const 'CrawlerSuppliersJob', collect_suppliers_urls_job

    CrawlerCategoriesJob.perform_now()

    expect(Category.first.name).to eq 'Bicicletas'
    expect(Category.first.slug).to eq 'bicicletas'
    expect(Category.count).to eq 12

    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('bicicletas')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('calcados')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('colchoes')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('drogarias')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('eletro')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('entretenimento')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('loja-de-artigos-em-geral')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('materia-prima')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('moveis')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('otica')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('pecas-servicos-automotivos')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('vestuario-em-geral')
  end

  it 'Only creates categories that do not exist' do
    events = Category.create!(name: 'Eventos, Bebidas e Alimentos')
    mattress = Category.create!(name: 'Colchões')
    services = Category.create!(name: 'Peças / Serviços Automotivos')

    CrawlerCategoriesJob.perform_now()

    expect(Category.find_by(name: events.name).slug).to eq 'entretenimento'
    expect(Category.find_by(name: mattress.name).slug).to eq 'colchoes'
    expect(Category.find_by(name: services.name).slug).to eq 'pecas-servicos-automotivos'
    expect(Category.count).to eq 12
  end
end
