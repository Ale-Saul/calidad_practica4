  When('I add the first product to the cart') do
    add_button = first('.inventory_item .btn_primary.btn_inventory', wait: 5)
    expect(add_button).not_to be_nil, "No 'Add to cart' button found for the first available product. Ensure you are on the inventory page."
    add_button.click
    expect(page).to have_selector('.shopping_cart_badge', text: '1', wait: 5)
  end
  
  When('I add the second product to the cart') do
    add_button = first('.inventory_item .btn_primary.btn_inventory', wait: 5)
    expect(add_button).not_to be_nil, "Could not find an available 'Add to cart' button for a second product. (Was the first product added and its button state updated?)"
    add_button.click
    expect(page).to have_selector('.shopping_cart_badge', text: '2', wait: 5)
  end
  
  When('I go to the cart') do
    find('.shopping_cart_link').click
    expect(page).to have_selector('#checkout', wait: 5)
  end
  
  When('I click the checkout button') do
    find('#checkout', wait: 5).click
  end
  
  When('I fill in my information with first name {string}, last name {string}, and postal code {string}') do |first, last, zip|
    fill_in 'First Name', with: first
    fill_in 'Last Name', with: last
    fill_in 'Zip/Postal Code', with: zip
  end
  
  When('I continue to the overview') do
    click_button('Continue')
  end
  
  When('I finish the purchase') do
    find('#finish', wait: 5).click
  end
  
  When('I cancel the purchase') do
    click_button('Cancel')
  end
  
  Then('I should see the confirmation message {string}') do |msg|
    expect(page).to have_content(msg)
  end

  When('I cancel the information entry') do
    click_button('Cancel')
  end

  Then('I should be redirected to the cart page') do
    expect(page).to have_current_path(/cart.html/, url: true)
    # También puedes verificar la presencia de algún elemento único del carrito:
    expect(page).to have_content('Your Cart')
  end

  Then('the total should be correct') do
    # Extrae precios de cada producto listado en el resumen
    prices = all('.inventory_item_price').map { |el| el.text.delete('$').to_f }
    subtotal = find('.summary_subtotal_label').text[/[\d\.]+/].to_f
    expect(prices.sum).to eq(subtotal)
  end