class CheckoutPage < BasePage
  FIRST_NAME_FIELD = 'input[data-test="firstName"]'
  LAST_NAME_FIELD  = 'input[data-test="lastName"]'
  POSTAL_CODE_FIELD = 'input[data-test="postalCode"]'
  CONTINUE_BUTTON  = 'input[data-test="continue"]'
  CANCEL_BUTTON    = 'button[data-test="cancel"]'
  FINISH_BUTTON    = 'button[data-test="finish"]'          # ← añadido
  ERROR_MESSAGE    = 'div.error-message-container'         # ← renombrado
  TITLE            = 'span[data-test="title"]'

  def fill_information(first_name, last_name, postal_code)
    find(FIRST_NAME_FIELD, wait: 10).set(first_name) if first_name
    find(LAST_NAME_FIELD,  wait: 10).set(last_name)  if last_name
    find(POSTAL_CODE_FIELD, wait: 10).set(postal_code) if postal_code
  end

  def continue
    find(CONTINUE_BUTTON).click
  end

  def cancel
    find(CANCEL_BUTTON).click
  end

  def finish_purchase
    find(FINISH_BUTTON, wait: 10).click
  end

  def error_message
    find(ERROR_MESSAGE, wait: 5).text
  rescue Capybara::ElementNotFound
    ''
  end

  def on_page?
    has_current_path?('/checkout-step-one.html') &&
      has_css?(TITLE, text: 'Checkout: Your Information')
  end

  def on_overview_page?
    has_current_path?('/checkout-step-two.html') &&
      has_css?(TITLE, text: 'Checkout: Overview')
  end

  def on_complete_page?
    has_current_path?('/checkout-complete.html') &&
      has_css?(TITLE, text: 'Checkout: Complete!')
  end

  def verify_order_total
    item_prices = page.all('.inventory_item_price').map { |p| p.text.delete('$').to_f }

    subtotal = find('.summary_subtotal_label').text[/\d+\.\d+/].to_f
    tax      = find('.summary_tax_label').text[/\d+\.\d+/].to_f
    total    = find('.summary_total_label').text[/\d+\.\d+/].to_f

    expect(subtotal).to eq(item_prices.sum.round(2))
    expect(total).to    eq((subtotal + tax).round(2))
  end
end