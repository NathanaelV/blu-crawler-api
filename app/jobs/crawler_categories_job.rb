class CrawlerCategoriesJob < ApplicationJob
  queue_as :default

  def perform()
    puts 'Job está funcionando Hahaha'
  end
end
