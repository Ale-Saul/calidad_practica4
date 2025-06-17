class CheckoutPage < BasePage
  FIRST_NAME_FIELD = 'First Name'
  LAST_NAME_FIELD = 'Last Name'
  POSTAL_CODE_FIELD = 'Zip/Postal Code'
  CONTINUE_BUTTON = 'Continue'
  CANCEL_BUTTON = 'Cancel'
  FINISH_BUTTON = '#finish'
  ERROR_SELECTOR = '[data-test="error"]'
  CONFIRMATION_MESSAGE_SELECTOR = '.complete-header'
  SUBTOTAL_SELECTOR = '.summary_subtotal_label'
  ITEM_PRICE_SELECTOR = '.cart_item_label .inventory_item_price'

  def fill_information(first_name:, last_name:, postal_code:)
    fill_in FIRST_NAME_FIELD, with: first_name
    fill_in LAST_NAME_FIELD, with: last_name
    fill_in POSTAL_CODE_FIELD, with: postal_code
  end

  def click_continue
    click_button CONTINUE_BUTTON
  end

  def click_cancel
    click_button CANCEL_BUTTON
  end

  def click_finish
    find(FINISH_BUTTON, wait: 5).click
  end

  def error_message
    find(ERROR_SELECTOR).text
  end

  def confirmation_message
    find(CONFIRMATION_MESSAGE_SELECTOR).text
  end

  def subtotal
    find(SUBTOTAL_SELECTOR).text[/[\d\.]+/].to_f
  end

  def item_prices
    all(ITEM_PRICE_SELECTOR).map { |el| el.text[/[\d\.]+/].to_f }
  end

  def total_correct?
    item_prices.sum.round(2) == subtotal.round(2)
  end

  def on_information_page?
    has_current_path?(/checkout-step-one.html/, url: true)
  end

  def on_overview_page?
    has_current_path?(/checkout-step-two.html/, url: true)
  end

  def go_back
    page.go_back
  end
end