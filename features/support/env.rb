require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'capybara-screenshot/cucumber'

require_relative 'pages/base_page'
require_relative 'pages/login_page'
require_relative 'pages/products_page'
require_relative 'pages/inventory_page'
require_relative 'pages/product_details_page'
require_relative 'pages/cart_page'
require_relative 'pages/checkout_page'

# --- Configuración de Capybara ---
Capybara.configure do |config|
  config.default_driver = :selenium_chrome
  config.app_host = 'https://www.saucedemo.com'
  config.default_max_wait_time = 10
end

# --- Hooks (Ganchos) ---
Before do
  Capybara.current_session.driver.browser.manage.window.maximize
  @login_page = LoginPage.new
  @products_page = ProductsPage.new
  @inventory_page = InventoryPage.new
  @product_details_page = ProductDetailsPage.new
  @cart_page = CartPage.new
  @checkout_page = CheckoutPage.new
end

Before('@login') do
  @login_page.visit_page
  @login_page.login_with('standard_user', 'secret_sauce')
  expect(@inventory_page.on_page?).to be(true)
end

After do |scenario|
  if scenario.failed?
    timestamp = Time.now.strftime('%Y-%m-%d-%H-%M-%S')
    screenshot_name = "screenshot-#{timestamp}.png"
    screenshot_path = File.join('tmp/capybara', screenshot_name)
    
    # Ensure directory exists
    FileUtils.mkdir_p('tmp/capybara') unless Dir.exist?('tmp/capybara')
    
    begin
      # Save screenshot with standard method
      page.save_screenshot(screenshot_path)
      puts "Screenshot saved to #{screenshot_path}"
    rescue => e
      puts "Failed to save screenshot: #{e.message}"
    end
  end
  Capybara.reset_sessions!
end

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
Capybara.default_max_wait_time = 15

Capybara.app_host = 'https://www.saucedemo.com'
Capybara.run_server = false

Capybara.save_path = "tmp/capybara"
Capybara::Screenshot.autosave_on_failure = true