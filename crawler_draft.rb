require 'selenium-webdriver'
require 'byebug'

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

driver.get "https://fornecedores.blu.com.br/"

begin
  # Wait for the page to load
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  
  # Wait for the presence of all li elements
  wait.until { driver.find_elements(tag_name: 'li').count > 2 }
  
  # Find all li elements
  elements = driver.find_elements(tag_name: 'li')
  
  # Salva as categorias
  categories = []
  elements.each do |e|
    categories << e.text
  end

  categories.shift

  # Clica em uma das categorias
  driver.find_element(link_text: categories[0]).click

  wait.until { driver.find_element(xpath: '//*[@id="root"]/div[1]/div[2]/div[4]/div/div/div/div[1]') }

  categorie_amount = driver.find_element(xpath: '//*[@id="root"]/div[1]/div[2]/div[4]/h3/p').text.to_i

  (1..categorie_amount).each do |num|
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    driver.find_element(xpath: "//*[@id='root']/div[1]/div[2]/div[4]/div/div/div/div[#{num}]/div[2]/p[1]").click
    wait.until { driver.window_handles.size > 1 }

    driver.switch_to.window(driver.window_handles.last)
    p driver.current_url

    # if driver.find_elements(xpath: '//*[@id="root"]/div[4]/div/div/div[2]/form/div[2]/button').size > 1
    #   p 'Digitar CNPJ'
    #   driver.find_element(:name, 'cnpj').send_keys('41.481.279/0001-50')
    #   driver.find_element(xpath: '//*[@id="root"]/div[4]/div/div/div[2]/form/div[2]/button').click
    #   byebug
    # end

    wait.until { driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[1]/div[2]/h2') }


    # Nome fantasia
    p driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[1]/div[2]/h2').text
    # Razão social
    p driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[1]/div[2]/p[1]').text
    # CNPJ
    p driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[1]/div[2]/p[2]').text

    # Segmento
    p driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[1]/div/span').text
    # Subsegmento
    p driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[2]/div/span').text   
    # Região de atendimento
    if driver.find_elements(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[3]/div/span').size > 0
      p driver.find_element(xpath: '//*[@id="root"]/div[2]/div[1]/section[2]/div[3]/div/span').text
    end
    

    # Voltar para a primeira página
    driver.close
    driver.switch_to.window(driver.window_handles.first)
    p driver.current_url
    puts '=' * 60
  end

rescue Selenium::WebDriver::Error => e
  puts "An error occurred: #{e.message}"
ensure
  # Close the browser
  driver.quit
end
