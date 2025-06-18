Given('I am a logged-in user') do
  @login_page.visit_page
  @login_page.login_with('standard_user', 'secret_sauce')
  expect(@inventory_page).to be_on_page
end

Given('I have added the product {string} to the cart') do |product|
  @inventory_page.add_product_to_cart(product)
  expect(@inventory_page.cart_badge_count).to eq(1)
end

Given('I proceed to checkout and complete my information') do
  @inventory_page  ||= InventoryPage.new
  @cart_page       ||= CartPage.new
  @checkout_info_page = CheckoutInfoPage.new
  @order_summary_page = OrderSummaryPage.new

  @inventory_page.go_to_cart
  expect(@cart_page).to be_on_page

  @cart_page.go_to_checkout
  expect(@checkout_info_page).to be_on_page   

  @checkout_info_page.fill_form(first: 'John', last: 'Doe', zip: '12345')
  @checkout_info_page.submit_form
end


Then('I am on the {string} page') do |page_name|
  case page_name
  when "Checkout: Overview"
    expect(page).to have_selector('.header_secondary_container') 
    expect(page).to have_selector('.header_secondary_container > span.title[data-test="title"]', text: 'Checkout: Overview')
  else
    raise "Unknown page name: #{page_name}"
  end
end


Then('I should see a title with text {string}') do |text|
  expect(@order_summary_page.on_page_with_title?(text)).to be true
end


Then('the title should be inside a container with class {string} and data-test {string}') do |klass, data_test|
  info = @order_summary_page.title_container_class_and_data_test
  expect(info[:class]).to include(klass)
  expect(info[:data_test]).to eq(data_test)
end

Then('the container should be inside a div with ID {string}') do |parent_id|
  parent = find("##{parent_id}")   

  expect(parent).to be_truthy

  expect(parent).to have_css('span.title[data-test="title"]', text: 'Checkout: Overview')
end

Then('I should see the order summary container') do
  expect(page).to have_css('#checkout_summary_container[data-test="checkout-summary-container"]')
end

Then('I should see a product listed with:') do |table|
  expected = table.hashes.first
  actual   = @order_summary_page.product_info

  expect(actual[:quantity]).to eq(expected['Quantity'])
  expect(actual[:name]).to     eq(expected['Name'])

  expect(actual[:description]).to include(expected['Description'])

  expect(actual[:price]).to    eq(expected['Price'])
end

Then('the product name should be a link to the item detail page') do
  expect(@order_summary_page.product_name_is_link?).to be true
end

Then('the product container should have the class {string} and data-test {string}') do |klass, data_test|
  info = @order_summary_page.product_container_class_and_data_test
  expect(info[:class]).to include(klass)
  expect(info[:data_test]).to eq(data_test)
end

Then('I should see the payment method as {string}') do |text|
  expect(@order_summary_page.payment_method).to eq(text)
end

Then('I should see the shipping method as {string}') do |text|
  expect(@order_summary_page.shipping_method).to eq(text)
end

Then('I should see a subtotal labeled {string}') { |l| expect(@order_summary_page.summary_label('subtotal')).to eq(l) }
Then('I should see a tax labeled {string}')      { |l| expect(@order_summary_page.summary_label('tax')).to      eq(l) }
Then('I should see a total labeled {string}')    { |l| expect(@order_summary_page.summary_label('total')).to    eq(l) }

Then('I should see a {string} button with data-test {string}') do |text, data_test|
  expect(@order_summary_page.has_button_with_text_and_data_test?(text, data_test)).to be true
end

When('I click the {string} button') do |text|
  @order_summary_page.click_button_by_text(text)

  if text == 'Finish'
    @checkout_complete_page = CheckoutCompletePage.new
  end
end

Then('I should be redirected to the checkout {string} page') do |title|
  expect(@checkout_complete_page).to be_on_page
  expect(@checkout_complete_page).to have_css('.title', text: "Checkout: #{title}")
end

Then('I should see the message {string}') do |message|
  expect(@checkout_complete_page.completion_message).to eq(message)
end

Then('I should be redirected back to the inventory page') do
  expect(@inventory_page).to be_on_page
end

Then('the cart should still contain the item') do
  expect(@inventory_page.cart_badge_count).to eq(1)
end

Then('all major elements should have appropriate data-test attributes:') do |table|
  expect(@order_summary_page.all_data_test_elements_present?(table.hashes)).to be true
end

Given('the item price is ${float} and tax is ${float}') do |item, tax|
  @expected_total = (item + tax).round(2)
end

Then('the total price should be ${float}') do |expected|
  actual_total = @order_summary_page.total_price
  expect(actual_total).to eq(expected)
end
