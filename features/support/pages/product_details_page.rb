class ProductDetailsPage < BasePage
  # --- Selectores ---
  PRODUCT_NAME = '.inventory_details_name'
  PRODUCT_DESC = '.inventory_details_desc'
  PRODUCT_PRICE = '.inventory_details_price'

  # Valida que estamos en la página de detalles del producto correcto
  def on_page_for?(product_name)
    page.has_css?(PRODUCT_NAME, text: product_name)
  end

  # Valida que la descripción y el precio son visibles
  def has_details_visible?
    page.has_css?(PRODUCT_DESC) && page.has_css?(PRODUCT_PRICE)
  end

  # Obtiene el precio del producto mostrado en la página
  def product_price
    find(PRODUCT_PRICE).text
  end
end 