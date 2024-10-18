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
  
    elements = driver.find_elements(tag_name: 'li')
    
    elements.each do |e|
      element_txt = e.text
      next if element_txt['Navegue por segmento'] || element_txt.empty?

      CollectSuppliersUrlsJob.perform_now(element_txt)
    end

    driver.quit
  end
end
