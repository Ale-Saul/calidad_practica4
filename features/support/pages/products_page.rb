class ProductsPage < BasePage
  ADD_TO_CART_BUTTONS = 'button[data-test^="add-to-cart"]'
  REMOVE_BUTTONS      = 'button[data-test^="remove-"]'
  CART_BADGE          = 'span[data-test="shopping-cart-badge"]'
  TITLE               = '.title'

  def displayed?
    on_page?
  end

  def add_first_product
    page.first(ADD_TO_CART_BUTTONS, wait: 5).click
  end

  def add_second_product
    buttons = page.all(ADD_TO_CART_BUTTONS, wait: 5)
    raise 'No se encontró un segundo producto' if buttons.size < 2
    buttons[1].click
  end

  def remove_all_items
    page.all(REMOVE_BUTTONS, wait: 5).each(&:click)
  end

  def on_page?
    has_current_path?('/inventory.html') &&
      has_css?(TITLE, text: 'Products', wait: 10)
  end
end
