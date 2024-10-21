class CrawlerCategoriesJob < ApplicationJob
  queue_as :default

  def perform()
    options = Selenium::WebDriver::Chrome::Options.new(
      args: [
        'headless',
        'start-maximized',
        'disable-gpu',
        'no-sandbox',
        'disable-setuid-sandbox',
        'disable-dable-dev-shm-usage'
      ]
    )

    driver = Selenium::WebDriver.for :chrome, options: options
    wait = Selenium::WebDriver::Wait.new(timeout: 10)

    driver.get "https://fornecedores.blu.com.br/"

    wait.until { driver.find_elements(tag_name: 'li').count > 2 }
  
    categories_text = driver.find_elements(tag_name: 'li').map {|e| e.text }
    categories_text.shift
    
    categories_text.each do |categorie_text|
      driver.find_element(link_text: categorie_text).click

      category_url = driver.current_url
      driver.navigate.back

      Category.find_or_create_by(name: categorie_text)

      CollectSuppliersUrlsJob.perform_later(category_url)
    end

    driver.quit
  end
end
