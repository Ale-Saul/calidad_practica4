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