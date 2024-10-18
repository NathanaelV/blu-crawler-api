class CollectSuppliersUrlsJob < ApplicationJob
  queue_as :default

  def perform(category_name)
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
  
    driver.find_element(link_text: category_name).click
    wait.until { driver.find_element(xpath: '//*[@id="root"]/div[1]/div[2]/div[4]/div/div/div/div[1]') }

    categorie_amount = driver.find_element(xpath: '//*[@id="root"]/div[1]/div[2]/div[4]/h3/p').text.to_i

    sleep 2
    (1..categorie_amount).each do |num|
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
      driver.find_element(xpath: "//*[@id='root']/div[1]/div[2]/div[4]/div/div/div/div[#{num}]/div[2]/p[1]").click
      wait.until { driver.window_handles.size > 1 }
  
      driver.switch_to.window(driver.window_handles.last)
      p driver.current_url

      driver.close
      driver.switch_to.window(driver.window_handles.first)
      p driver.current_url
      puts '=' * 60
      sleep 2
    end

    driver.quit
  end
end
