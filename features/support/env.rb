require 'capybara/cucumber'
require 'selenium-webdriver'

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--incognito')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :selenium_chrome
Capybara.default_max_wait_time = 10