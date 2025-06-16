Given('I am on the SauceDemo login page') do
  @login_page.visit_page
end

When('I login with username {string} and password {string}') do |username, password|
  @login_page.login_with(username, password)
end

Then('I should be redirected to the products page') do
  expect(@products_page.on_page?).to be(true), "Error: No se redirigió a la página de productos."
end

Then('I should see the error message {string}') do |error_message|
  expect(@login_page.error_message_text).to include(error_message)
end
  