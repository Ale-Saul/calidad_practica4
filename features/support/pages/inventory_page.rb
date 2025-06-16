class InventoryPage < BasePage
  # --- Selectores ---
  INVENTORY_CONTAINER = '#inventory_container'
  INVENTORY_ITEM = '.inventory_item'
  ITEM_NAME = '.inventory_item_name'
  ITEM_PRICE = '.inventory_item_price'
  ADD_TO_CART_BUTTON = '.btn_inventory'
  SORT_DROPDOWN = '[data-test="product-sort-container"]'

  # --- Métodos ---

  # Valida que la página de inventario se ha cargado correctamente
  def on_page?
    page.has_css?(INVENTORY_CONTAINER) && page.has_css?('.title', text: 'Products')
  end

  # Devuelve una lista con los nombres de todos los productos visibles
  def product_names_list
    expect(page).to have_css(INVENTORY_CONTAINER)
    page.all(ITEM_NAME).map(&:text)
  end

  # Devuelve una lista con los precios de todos los productos visibles
  def product_prices_list
    expect(page).to have_css(INVENTORY_CONTAINER)
    page.all(ITEM_PRICE).map(&:text)
  end

  # Devuelve un hash {Nombre => Precio} de todos los productos
  def products
    expect(page).to have_css(INVENTORY_CONTAINER)
    product_elements = page.all(INVENTORY_ITEM)
    
    product_elements.each_with_object({}) do |item, hash|
      name = item.find(ITEM_NAME).text
      price = item.find(ITEM_PRICE).text
      hash[name] = price
    end
  end

  # Selecciona una opción del menú desplegable de ordenamiento
  def sort_by(option)
    find(SORT_DROPDOWN).select(option)
  end

  # Hace clic en el nombre de un producto específico para ver sus detalles
  def view_product_details(product_name)
    find(ITEM_NAME, text: product_name).click
  end

  # Añade un producto al carrito por su nombre
  def add_product_to_cart(product_name)
    # Busca el contenedor del producto y luego el botón dentro de él
    item_container = find(INVENTORY_ITEM, has_text: product_name)
    item_container.find(ADD_TO_CART_BUTTON).click
  end
end 