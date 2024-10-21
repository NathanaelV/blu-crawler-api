class CollectSuppliersUrlsJob < ApplicationJob
  queue_as :default

  def perform(category_url)
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

    driver.get category_url
    wait.until { driver.find_element(xpath: '//*[@id="root"]/div[1]/div[2]/div[4]/div/div/div/div[1]') }

    categorie_amount = driver.find_element(xpath: '//*[@id="root"]/div[1]/div[2]/div[4]/h3/p').text.to_i

    (1..categorie_amount).each do |num|
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
      driver.find_element(xpath: "//*[@id='root']/div[1]/div[2]/div[4]/div/div/div/div[#{num}]/div[2]/p[1]").click
  
      driver.switch_to.window(driver.window_handles.last)
      supplier_url = driver.current_url

      next if Supplier.find_by(url: supplier_url)

      CrawlerSuppliersJob.perform_later(supplier_url)

      driver.close
      driver.switch_to.window(driver.window_handles.first)
    end

    driver.quit
  end
end
