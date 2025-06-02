When('I add all products to the cart') do
  all('.btn_inventory').each do |button|
    button.click
    sleep 0.5
  end
end

Then('the cart badge should show the total number of products') do
  total_products = all('.inventory_item').count
  expect(page).to have_css('.shopping_cart_badge', text: total_products.to_s, wait: 5)
  sleep 1
end

When('I remove all products from the cart') do
  all('button[id^="remove"]').each do |button|
    button.click
    sleep 0.5
  end
end

When('I add {string} to the cart') do |product_name|
  within(:xpath, "//div[contains(@class, 'inventory_item') and .//div[text()='#{product_name}']]") do
    click_button 'Add to cart'
  end
  sleep 1
end

When('I select the filter {string}') do |option|
  find('.product_sort_container').select(option)
end

When('I wait for the products to be sorted') do
  sleep 1 # Puedes mejorar esto usando un wait explícito si lo deseas
end

Then('the products should be sorted alphabetically ascending') do
  product_names = all('.inventory_item_name').map(&:text)
  expect(product_names).to eq(product_names.sort)
end

Then('the products should be sorted alphabetically descending') do
  product_names = all('.inventory_item_name').map(&:text)
  expect(product_names).to eq(product_names.sort.reverse)
end

Then('the products should be sorted by price ascending') do
  prices = all('.inventory_item_price').map { |price| price.text.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort)
end

Then('the products should be sorted by price descending') do
  prices = all('.inventory_item_price').map { |price| price.text.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort.reverse)
end