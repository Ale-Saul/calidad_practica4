Given('I am logged in as standard user') do
  @login_page.visit_page
  @login_page.login_with('standard_user', 'secret_sauce')
  expect(@products_page).to be_displayed
end

Given('I have added one product to my cart') do
  @products_page.add_first_product
  expect(page).to have_css(CartPage::CART_BADGE, text: '1', wait: 5)
end

Given('I have added two products to my cart') do
  @cart_page.visit_page
  @cart_page.remove_all_items if @cart_page.item_count.positive?

  visit '/inventory.html'
  @products_page.add_first_product
  @products_page.add_second_product

  expect(page).to have_css(CartPage::CART_BADGE, text: '2', wait: 5)
end


When('I proceed to checkout with:') do |table|
  @cart_page.visit_page
  @cart_page.go_to_checkout
  
  unless @checkout_page.on_page?
    puts "Failed to reach checkout page. Current URL: #{current_url}"
    puts "Page HTML:\n#{page.html}"
  end
  
  data = table.rows_hash
  @checkout_page.fill_information(data['First Name'], data['Last Name'], data['Zip Code'])
  @checkout_page.continue
end

When('I start checkout process') do
  @cart_page.visit_page
  @cart_page.go_to_checkout
  expect(@checkout_page).to be_on_page
end

Given('I have removed all products from cart') do
  @cart_page.visit_page
  @cart_page.remove_all_items
  expect(@cart_page).to have_no_items
end

When('I complete the purchase') do
  @checkout_page.finish_purchase
end

When('I attempt checkout with:') do |table|
  @cart_page.visit_page           # ← obligatorio
  @cart_page.go_to_checkout
  data = table.rows_hash
  @checkout_page.fill_information(data['First Name'], data['Last Name'], data['Zip Code'])
  @checkout_page.continue
end

When('I cancel from information page') do
  @checkout_page.cancel
end

When('I cancel the order') do
  @checkout_page.cancel
end

When('I attempt to start checkout') do
  @cart_page.visit_page

  if @cart_page.item_count.positive?
    @cart_page.go_to_checkout
  end
end



When('I enter initial checkout information:') do |table|
  data = table.rows_hash
  @checkout_page.fill_information(data['First Name'], data['Last Name'], data['Zip Code'])
  @checkout_page.continue
end

When('I review order summary') do
  expect(@checkout_page).to be_on_overview_page
end

When('I return to information page') do
  page.go_back
end

When('I modify information with:') do |table|
  data = table.rows_hash
  @checkout_page.fill_information(data['First Name'], data['Last Name'], data['Zip Code'])
  @checkout_page.continue
end

Then('I should see the order confirmation') do
  expect(@checkout_page).to be_on_complete_page
  expect(page).to have_content('Thank you for your order')
end

Then('I should see the error {string}') do |message|
  expect(@checkout_page.error_message).to include(message)
end

Then('I should return to my cart') do
  expect(@cart_page).to be_on_page
end

Then('I should return to products page') do
  expect(@products_page).to be_displayed
end

Then('the order summary should show correct total') do
  @checkout_page.verify_order_total
end

Then('I should remain on cart page') do
  expect(@cart_page).to be_on_page
end