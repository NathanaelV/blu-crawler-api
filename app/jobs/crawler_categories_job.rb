class CrawlerCategoriesJob < ApplicationJob
  queue_as :default

  def perform()
    response = Faraday.get('https://repnota1000.blu.com.br/api/v1/departments')
    departments = JSON.parse(response.body)['departments']
    departments.each do |department|
      slug = department['slug']
      category = Category.find_or_create_by(name: department['name'])
      category.update(slug: slug)

      CrawlerSuppliersJob.perform_later(slug)
    end
  end
end
