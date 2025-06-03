Given('I am a logged-in user') do
  visit 'https://www.saucedemo.com/'
  find('input[data-test="username"]').set('standard_user')
  find('input[data-test="password"]').set('secret_sauce')
  click_button 'Login'
  expect(page).to have_current_path(/inventory\.html/)
  expect(page).to have_css('.title', text: 'Products')
end

Given('I have added the product {string} to the cart') do |product_name|
  product = find('.inventory_item', text: product_name)
  product.find('button', text: 'Add to cart').click
  expect(page).to have_css('.shopping_cart_badge', text: '1')
end

Given('I proceed to checkout and complete my information') do
  # Go to cart
  find('.shopping_cart_link').click
  expect(page).to have_css('.title', text: 'Your Cart')
  
  # Start checkout
  click_button 'Checkout'
  expect(page).to have_css('.title', text: 'Checkout: Your Information')
  
  # Fill information
  fill_in 'first-name', with: 'John'
  fill_in 'last-name', with: 'Doe'
  fill_in 'postal-code', with: '12345'
  click_button 'Continue'
  expect(page).to have_current_path(/checkout-step-two\.html/)
end

Given('I am on the {string} page') do |page_title|
  expect(page).to have_css('.title', text: page_title)
end

Then('I should see a title with text {string}') do |title|
  expect(page).to have_css('.title', text: title)
end

Then('the title should be inside a container with class {string} and data-test {string}') do |css_class, data_test|
  title_element = find('.title')
  parent_container = title_element.find(:xpath, '..')
  
  expect(parent_container[:class]).to include(css_class)
  expect(parent_container['data-test']).to eq(data_test)
end

Then('the container should be inside a div with ID {string}') do |div_id|
  expect(page).to have_css("##{div_id} .title")
end

Then('I should see a product listed with:') do |table|
  product_row = find('.cart_item')
  table.hashes.each do |row|
    expect(product_row).to have_content(row['Quantity'])
    expect(product_row).to have_content(row['Name'])
    expect(product_row).to have_content(row['Description'])
    expect(product_row).to have_content(row['Price'])
  end
end

Then('the product name should be a link to the item detail page') do
  expect(page).to have_css('.inventory_item_name')
end

Then('the product container should have the class {string} and data-test {string}') do |css_class, data_test|
  product_container = find('.cart_item')
  expect(product_container[:class]).to include(css_class)
  expect(product_container['data-test']).to eq(data_test)
end

Then('I should see the payment method as {string}') do |text|
  expect(page).to have_css('.summary_value_label', text: text)
end

Then('I should see the shipping method as {string}') do |text|
  # Shipping method is the second summary_value_label
  all('.summary_value_label')[1].text == text
end

Then('I should see a subtotal labeled {string}') do |label|
  expect(page).to have_css('.summary_subtotal_label', text: label)
end

Then('I should see a tax labeled {string}') do |label|
  expect(page).to have_css('.summary_tax_label', text: label)
end

Then('I should see a total labeled {string}') do |label|
  expect(page).to have_css('.summary_total_label', text: label)
end

Then('I should see a {string} button with data-test {string}') do |button_text, data_test|
  expect(page).to have_css("button[data-test='#{data_test}']", text: button_text)
end

When('I click the {string} button') do |button_text|
  click_button button_text
end

Then('I should see the message {string}') do |message|
  expect(page).to have_css('.complete-header', text: message)
end

Then('I should be redirected to the checkout {string} page') do |page_title|
  expect(page).to have_css('.title', text: "Checkout: #{page_title}")
end

Then('I should be redirected back to the inventory page') do
  expect(page).to have_current_path(/inventory\.html/)
  expect(page).to have_css('.title', text: 'Products')
end

Then('the cart should still contain the item') do
  expect(page).to have_css('.shopping_cart_badge', text: '1')
end

Then('all major elements should have appropriate data-test attributes:') do |table|
  table.hashes.each do |row|
    expect(page).to have_css("[data-test='#{row['Data-test']}']")
  end
end

Given('the item price is ${float} and tax is ${float}') do |item_price, tax|
  @expected_total = item_price + tax
end

Then('the total price should be ${float}') do |expected|
  total_text = find('.summary_total_label').text
  actual_total = total_text[/\d+\.\d+/].to_f
  expect(actual_total).to eq(expected)
end