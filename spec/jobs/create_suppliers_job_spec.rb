require 'rails_helper'
RSpec.describe CreateSuppliersJob, type: :job do
  it 'Active Jobs' do
    first_data = {
      suppliers: [
        id: 2,
        cpf_cnpj: '35806380000130',
        name: '1 Click Interiores',
        slug: '1-click-interiores',
        departments: [
          {
            id: 9,
            name: 'Colchões',
            slug: 'colchoes'
          },
          {
            id: 45,
            name: 'Móveis',
            slug: 'moveis'
          }
        ],
        positions: [
          {
            id: 9,
            uf: 'GO',
            name: 'Goiás',
            slug: 'goias'
          },
          {
            id: 13,
            uf: 'MG',
            name: 'Minas Gerais',
            slug: 'minas-gerais'
          }
        ]
      ],
      total_pages: 2
    }
    second_data = {
      suppliers: [
        id: 4543,
        cpf_cnpj: '38496592000157',
        name: '20 20 Laboratório Óptico',
        slug: 'oculos-so-conserto-ltda',
        departments: [
          {
            id: 36,
            name: 'Ótica',
            slug: 'otica'
          }
        ],
        positions: [
          {
            id: 13,
            uf: 'MG',
            name: 'Minas Gerais',
            slug: 'minas-gerais'
          }
        ]
      ],
      total_pages: 2
    }

    first_response = double('faraday_response', body: first_data.to_json)
    second_response = double('faraday_response', body: second_data.to_json)

    allow(Faraday).to receive(:get).with('https://repnota1000.blu.com.br/api/v1/suppliers?per_page=100')
                                   .and_return(first_response)
    allow(Faraday).to receive(:get).with('https://repnota1000.blu.com.br/api/v1/suppliers?page=1&per_page=100')
                                   .and_return(first_response)

    allow(Faraday).to receive(:get).with('https://repnota1000.blu.com.br/api/v1/suppliers?page=2&per_page=100')
                                   .and_return(second_response)

    CreateSuppliersJob.perform_now()

    expect(Category.first.name).to eq 'Colchões'
    expect(Category.first.slug).to eq 'colchoes'
    expect(Category.find_by(slug: 'moveis').name).to eq 'Móveis'
    expect(Category.find_by(slug: 'otica').name).to eq 'Ótica'
    expect(Category.count).to eq 3

    expect(Supplier.first.name).to eq '1 Click Interiores'
    expect(Supplier.first.cnpj).to eq '35806380000130'
    expect(Supplier.first.slug).to eq '1-click-interiores'
    expect(Supplier.first.categories.first.name).to eq 'Colchões'
    expect(Supplier.first.categories.last.name).to eq 'Móveis'
    expect(Supplier.first.states.first.name).to eq 'Goiás'
    expect(Supplier.first.states.first.uf).to eq 'GO'
    expect(Supplier.first.states.first.slug).to eq 'goias'
  end
end
