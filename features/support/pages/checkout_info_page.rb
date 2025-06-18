class CheckoutInfoPage < BasePage
  FIRST_NAME_INPUT   = 'input[data-test="firstName"]'.freeze
  LAST_NAME_INPUT    = 'input[data-test="lastName"]'.freeze
  ZIP_INPUT          = 'input[data-test="postalCode"]'.freeze
  CONTINUE_BUTTON    = 'input[data-test="continue"]'.freeze   # es un <input type="submit">
  TITLE              = '.title'.freeze               #   <span class="title">Checkout: Your Information</span>
  EXPECTED_TITLE     = 'Checkout: Your Information'.freeze

  def on_page?
    has_css?(TITLE, text: EXPECTED_TITLE, wait: 5)
  end

  def fill_form(first:, last:, zip:)
    fill_in_field(FIRST_NAME_INPUT, first)
    fill_in_field(LAST_NAME_INPUT,  last)
    fill_in_field(ZIP_INPUT,        zip)
  end

  def submit_form
    find(CONTINUE_BUTTON, wait: 5).click
  end

  private

  def fill_in_field(selector, value)
    field = find(selector, wait: 5)
    field.set(value)
  end
end
