class Apis::FetchSuppliers
  def fetch_first_page
    response = Faraday.get('https://repnota1000.blu.com.br/api/v1/suppliers?per_page=100')
    JSON.parse(response.body, symbolize_names: true)
  end

  def fetch_other_pages(page)
    response = Faraday.get("https://repnota1000.blu.com.br/api/v1/suppliers?page=#{page}&per_page=100")
    JSON.parse(response.body, symbolize_names: true)
  end
end
