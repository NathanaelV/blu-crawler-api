require 'rails_helper'
RSpec.describe CollectSuppliersUrlsJob, type: :job do
  it 'Active Jobs to bicicletas' do
    collect_suppliers_urls_job = spy('CrawlerSuppliersJob')
    stub_const 'CrawlerSuppliersJob', collect_suppliers_urls_job
    category_url = 'https://fornecedores.blu.com.br/segmento/bicicletas'

    CollectSuppliersUrlsJob.perform_now(category_url)
    
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/bicicletas/caloi-norte-sa')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/bicicletas/ducce-bike-industria-e-comercio-ltda')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/bicicletas/l-tavares-cancian-da-silva-bicicletaria')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/bicicletas/california-bike-ltda')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/bicicletas/vitta-industria-e-comercio-de-bicicletas-ltda')
  end

  it 'Active Jobs to vetuario' do
    collect_suppliers_urls_job = spy('CrawlerSuppliersJob')
    stub_const 'CrawlerSuppliersJob', collect_suppliers_urls_job
    category_url = 'https://fornecedores.blu.com.br/segmento/vestuario-em-geral'

    CollectSuppliersUrlsJob.perform_now(category_url)
    
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/vestuario-em-geral/alien-industria-e-comercio-de-produtos-militares-ltda')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/vestuario-em-geral/confeccoes-aconchego-do-bebe-ltda')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/vestuario-em-geral/inbrands-s-a')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/vestuario-em-geral/industria-e-comercio-de-confeccoes-la-moda-ltda')
    expect(CrawlerSuppliersJob).to have_received(:perform_later).with('https://fornecedores.blu.com.br/segmento/vestuario-em-geral/urbo-industria-e-comercio-de-confeccoes-ltda')
  end
end
