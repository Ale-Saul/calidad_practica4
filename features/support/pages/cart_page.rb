class CartPage < BasePage
  CHECKOUT_BUTTON          = 'button[data-test="checkout"]'
  CONTINUE_SHOPPING_BUTTON = 'button[data-test="continue-shopping"]'
  REMOVE_BUTTONS           = 'button[data-test^="remove-"]'
  CART_ITEMS               = 'div[data-test="inventory-item"]'
  CART_BADGE               = 'span[data-test="shopping-cart-badge"]'
  TITLE                    = '.title'                    # ← añadido

  def visit_page
    visit '/cart.html'
    expect(on_page?).to be true
  end

  def go_to_checkout
    visit_page unless on_page?
    find(CHECKOUT_BUTTON, wait: 10).click
  end

  def continue_shopping
    find(CONTINUE_SHOPPING_BUTTON, wait: 5).click
  end

  def remove_all_items
    page.all(REMOVE_BUTTONS, wait: 5).each(&:click)
  end

  def item_count
    page.all(CART_ITEMS, wait: 1).count
  end

  def on_page?
    has_current_path?('/cart.html') &&
      has_css?(TITLE, text: 'Your Cart', wait: 10)
  end

  def has_no_items?
    has_no_css?(CART_ITEMS, wait: 5)
  end
end
