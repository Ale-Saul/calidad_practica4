Given('I am on the Swag Labs login page') do
  visit('/')
end

Given('I enter valid credentials') do
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'Login'
  expect(page).to have_current_path('/inventory.html', wait: 5)
end

Then('I am redirected to the product inventory page') do
  expect(page.current_url).to eq('https://www.saucedemo.com/inventory.html')
end

Then('I should see the inventory title as {string}') do |string|
  expect(page).to have_css('.title', text: string)
end

Then('I should see the following products:') do |table|
  expected_names = table.raw.drop(1).map { |row| row[0] }
  displayed_names = all('.inventory_item_name').map(&:text)
  expect(displayed_names).to match_array(expected_names)
end

When('I select {string} from the sort dropdown') do |option|
  using_wait_time 5 do
    find('select[data-test="product-sort-container"]').select(option)
  end
end

Then('I should see the following sorted products:') do |table|
  expected_order = table.raw.flatten.drop(1)
  actual_order = all('.inventory_item_name').map(&:text)
  expect(actual_order).to eq(expected_order)
end

Then('I should see the following sorted products by price:') do |table|
  expected_prices = table.raw.drop(1).map { |row| row[1] }  
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