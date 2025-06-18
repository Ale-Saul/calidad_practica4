class CheckoutCompletePage < BasePage
  TITLE_SELECTOR   = '.title'.freeze
  MESSAGE_SELECTOR = '.complete-header'.freeze

  # ¿Estoy en la página “Checkout: Complete!”?
  def on_page?
    has_css?(TITLE_SELECTOR, text: 'Checkout: Complete!', wait: 5)
  end

  # Texto “Thank you for your order!”
  def completion_message
    find(MESSAGE_SELECTOR, wait: 5).text
  end
end
