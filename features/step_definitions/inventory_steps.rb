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

Given('I am on the product inventory page') do
  expect(@inventory_page.on_page?).to be(true)
end

Then('I should see the inventory title as {string}') do |title|
  expect(page).to have_css('.title', text: title)
end

Then('I should see the following products:') do |table|
  expected_products = table.hashes.map { |row| [row['Name'], row['Price']] }.to_h
  actual_products = @inventory_page.products
  expect(actual_products).to eq(expected_products)
end

When('I select {string} from the sort dropdown') do |option|
  @inventory_page.sort_by(option)
end

Then('I should see the following sorted products:') do |table|
  expected_order = table.raw.flatten.drop(1)
  expect(@inventory_page.product_names_list).to eq(expected_order)
end

Then('I should see the following sorted products by price:') do |table|
  expected_prices = table.hashes.map { |row| row['Price'] }
  expect(@inventory_page.product_prices_list).to eq(expected_prices)
end

When('I click on the product name {string}') do |product_name|
  @inventory_page.view_product_details(product_name)
end

Then('I should be on the product details page for {string}') do |product_name|
  expect(@product_details_page.on_page_for?(product_name)).to be(true)
end

Then('the product description should be visible') do
  expect(@product_details_page.has_details_visible?).to be(true)
end

Then('the product price should be {string}') do |expected_price|
  expect(@product_details_page.product_price).to eq(expected_price)
end

# --- Pasos para selección de productos ---

Given('I have added every available item to the cart') do
  @inventory_page.add_all_products_to_cart
end

When('I add every available item to the cart') do
  @inventory_page.add_all_products_to_cart
end

When('I remove every item from the cart') do
  @inventory_page.remove_all_products_from_cart
end

Then('the cart icon should show a badge with the correct number of items') do
  expect(@inventory_page.cart_badge_count).to eq(@inventory_page.product_count)
end

Then('the cart icon badge should disappear') do
  expect(@inventory_page.cart_badge_count).to eq(0)
end