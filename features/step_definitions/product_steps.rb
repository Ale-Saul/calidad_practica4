Given('I add all products to the cart') do
  step('I add all products to the cart')
end

When('I add all products to the cart') do
  @inventory_page.add_all_products_to_cart
end

Then('the cart badge should show the total number of products') do
  expect(@inventory_page.cart_badge_count).to eq(@inventory_page.product_count)
end

When('I remove all products from the cart') do
  @inventory_page.remove_all_products_from_cart
end

When('I add {string} to the cart') do |product_name|
  @inventory_page.add_product_to_cart(product_name)
end

When('I wait for the products to be sorted') do
  sleep 0.5
end

Then('the cart badge should be empty') do
  expect(@inventory_page.cart_badge_count).to eq(0)
end

When('I select the filter {string}') do |option|
  @inventory_page.sort_by(option)
end

Then('the products should be sorted alphabetically ascending') do
  product_names = @inventory_page.product_names_list
  expect(product_names).to eq(product_names.sort)
end

Then('the products should be sorted alphabetically descending') do
  product_names = @inventory_page.product_names_list
  expect(product_names).to eq(product_names.sort.reverse)
end

Then('the products should be sorted by price ascending') do
  prices = @inventory_page.product_prices_list.map { |price| price.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort)
end

Then('the products should be sorted by price descending') do
  prices = @inventory_page.product_prices_list.map { |price| price.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort.reverse)
end