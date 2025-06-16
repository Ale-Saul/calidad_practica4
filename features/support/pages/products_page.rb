class ProductsPage < BasePage
  # --- Selectores ---
  PRODUCTS_TITLE = '.title'

  # Método para validar que estamos en la página correcta.
  # Comprueba la URL y la presencia del título "Products".
  def on_page?
    page.has_current_path?(/inventory\.html/, wait: 5) &&
      page.has_css?(PRODUCTS_TITLE, text: 'Products')
  end
end 