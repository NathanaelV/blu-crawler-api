class CrawlerSuppliersJob < ApplicationJob
  queue_as :default

  def perform(supplier_url)
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

    driver.get supplier_url

    wait.until { driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[1]/div[2]/h2') }

    name = driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[1]/div[2]/h2').text

    category_name = driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[1]/div/span').text

    if third_exist?(driver)
      state_name = driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[3]/div/span').text
    elsif second_state?(driver)
      state_name = driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[2]/div/span').text
    else
      state_name = 'Sem região cadastrada'
    end

    states_name = state_name.split(', ')

    category = Category.find_or_create_by(name: category_name)
    supplier = Supplier.create_with(category:, name:).find_or_create_by(url: supplier_url)

    states_name.each do |state_name|
      supplier.states << State.find_or_create_by(name: state_name)
    end

    driver.quit
  end

  private

  def second_state?(driver)
    driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[2]/div/h4').text == 'Regiões de atendimento'
  end

  def third_exist?(driver)
    driver.find_elements(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[3]/div/span').size > 0
  end
end
