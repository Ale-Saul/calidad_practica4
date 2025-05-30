  When('I add the first product to the cart') do
    expect(page).to have_selector('.btn_inventory', wait: 5)
    first('.btn_inventory').click
    # Verifica que el carrito tenga al menos 1 producto
    expect(page).to have_selector('.shopping_cart_badge', text: '1', wait: 5)
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