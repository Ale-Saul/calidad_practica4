class InventoryPage < BasePage
  include RSpec::Matchers
  # --- Selectores ---
  INVENTORY_CONTAINER = '#inventory_container'
  INVENTORY_ITEM = '.inventory_item'
  ITEM_NAME = '.inventory_item_name'
  ITEM_PRICE = '.inventory_item_price'
  ADD_TO_CART_BUTTON = '.btn_inventory'
  SORT_DROPDOWN = '[data-test="product-sort-container"]'

  def on_page?
    page.has_css?(INVENTORY_CONTAINER) && page.has_css?('.title', text: 'Products')
  end

  def product_names_list
    page.all(ITEM_NAME, minimum: 1).map(&:text)
  end

  def product_prices_list
    page.all(ITEM_PRICE, minimum: 1).map(&:text)
  end

  def products
    page.all(INVENTORY_ITEM, minimum: 1).each_with_object({}) do |item, h|
      h[item.find(ITEM_NAME).text] = item.find(ITEM_PRICE).text
    end
  end

  def sort_by(option)
    find(SORT_DROPDOWN).select(option)
  end

  def view_product_details(product_name)
    find(ITEM_NAME, text: product_name).click
  end

  def add_product_to_cart(product_name)
    item_container = page.all(INVENTORY_ITEM).find do |item|
      item.has_css?(ITEM_NAME, text: product_name)
    end
    raise "Producto '#{product_name}' no encontrado" unless item_container

    item_container.find('button', text: 'Add to cart').click
  end

  def product_count
    page.all(INVENTORY_ITEM, minimum: 1).count
  end

  def add_all_products_to_cart
    page.all('button', text: 'Add to cart').each(&:click)
  end

  def remove_all_products_from_cart
    page.all('button', text: 'Remove').each(&:click)
  end
end 