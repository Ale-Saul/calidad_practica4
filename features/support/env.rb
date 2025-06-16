# Este archivo se usará para configurar el entorno de Cucumber.
# Se cargará automáticamente antes de que se ejecuten las pruebas.

require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec/expectations'

Capybara.register_driver :chrome_incognito do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--incognito')
  options.add_argument('--disable-infobars')
  options.add_argument('--disable-notifications')
  options.add_argument('--disable-extensions')
  options.add_argument('--start-maximized')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :chrome_incognito
Capybara.javascript_driver = :chrome_incognito

Capybara.app_host = 'https://www.saucedemo.com'
Capybara.run_server = false