Given('I am on the SauceDemo login page') do
  @login_page.visit_page
end

When('I login with username {string} and password {string}') do |username, password|
  @login_page.login_with(username, password)
end

Given('I click the login button') do
  @login_page.submit
end

Then('I should be redirected to the products page after login') do
  expect(@products_page).to be_displayed
  # Or alternatively:
  # expect(@products_page).to be_on_page
end

Then('I should see the login error message {string}') do |message|
  expect(@login_page.error_message_text).to include(message)
end