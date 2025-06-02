Given('I am on the Swag Labs login page') do
  visit('/')
end

Given('I enter valid credentials') do
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'Login'
end

Given('I am redirected to the product inventory page') do
  expect(page).to have_current_path('/inventory.html', url: true)
end

Then('I should see the inventory title as {string}') do |string|
  expect(page).to have_css('.title', text: string)
end

Then('I should see the following products:') do |table|
  products = table.raw.flatten
  displayed_products = all('.inventory_item_name').map(&:text)
  expect(displayed_products).to match_array(products)
end

When('I select {string} from the sort dropdown') do |option_text|
  select option_text, from: 'product_sort_container'
end

Then('I should see the following sorted products:') do |table|
  expected_order = table.raw.flatten
  actual_order = all('.inventory_item_name').map(&:text)
  expect(actual_order).to eq(expected_order)
end

Then('I should see the following sorted products by price:') do |table|
  expected_prices = table.raw.flatten
  actual_prices = all('.inventory_item_price').map(&:text)
  expect(actual_prices).to eq(expected_prices)
end

When('I click on the product name {string}') do |product_name|
  find('.inventory_item_name', text: product_name).click
end

Then('I should be on the product details page for {string}') do |product_name|
  expect(page).to have_css('.inventory_details_name', text: product_name)
end

Then('the product description should be visible') do
  expect(page).to have_css('.inventory_details_desc')
end

Then('the product price should be {string}') do |expected_price|
  expect(page).to have_css('.inventory_details_price', text: expected_price)
end