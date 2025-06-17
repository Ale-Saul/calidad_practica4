# Este archivo se usará para configurar el entorno de Cucumber.
# Se cargará automáticamente antes de que se ejecuten las pruebas.

require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'capybara-screenshot/cucumber'

# Carga la clase base PRIMERO, ya que otras clases heredan de ella.
require_relative 'pages/base_page'
# Carga las demás clases de Page Objects
require_relative 'pages/login_page'
require_relative 'pages/products_page'
require_relative 'pages/inventory_page'
require_relative 'pages/product_details_page'
require_relative 'pages/checkout_page'

# --- Configuración de Capybara ---
Capybara.configure do |config|
  config.default_driver = :selenium_chrome
  config.app_host = 'https://www.saucedemo.com'
  config.default_max_wait_time = 10
end

# --- Hooks (Ganchos) ---

# Se ejecuta ANTES de cada escenario
Before do
  Capybara.current_session.driver.browser.manage.window.maximize
  @login_page = LoginPage.new
  @products_page = ProductsPage.new
  @inventory_page = InventoryPage.new
  @product_details_page = ProductDetailsPage.new
  @checkout_page = CheckoutPage.new
end

# Hook con etiqueta para escenarios que requieren estar logueado
Before('@login') do
  # Usamos el Page Object para hacer el login, manteniendo el código limpio
  @login_page.visit_page
  @login_page.login_with('standard_user', 'secret_sauce')
  # Verificamos que el login fue exitoso antes de continuar
  expect(@inventory_page.on_page?).to be(true)
end

# Se ejecuta DESPUÉS de cada escenario
After do |scenario|
  if scenario.failed?
    # Esta gema guarda una captura y la abre en el navegador
    #save_and_open_screenshot
  end
  # Limpia la sesión para que las pruebas no interfieran entre sí
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

Capybara.app_host = 'https://www.saucedemo.com'
Capybara.run_server = false