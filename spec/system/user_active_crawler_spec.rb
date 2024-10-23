require 'rails_helper'

describe 'User active crawler' do
  it 'click on button' do
    crawler_categories_job_spy = spy('CreateSuppliersJob')
    stub_const 'CreateSuppliersJob', crawler_categories_job_spy

    visit root_path
    click_on 'Coletar informações'
    
    expect(CreateSuppliersJob).to have_received(:perform_later)
    expect(current_path).to eq '/crawler_running'
  end
end
