# BasePage contiene la funcionalidad común a varias páginas de la aplicación.
# Todas las demás clases de página heredarán de esta para reutilizar código.

class BasePage
  include Capybara::DSL
  include RSpec::Matchers

  # --- Selectores de Elementos Comunes ---
  SHOPPING_CART_ICON = '.shopping_cart_link'
  SIDEBAR_MENU_BUTTON = '#react-burger-menu-btn'
  LOGOUT_LINK = '#logout_sidebar_link'
  CART_BADGE = '.shopping_cart_badge'

  # --- Métodos de Acciones Comunes ---

  # Navega a la página del carrito de compras haciendo clic en el ícono
  def go_to_cart
    find(SHOPPING_CART_ICON).click
  end

  # Realiza el proceso de logout a través del menú lateral
  def logout
    find(SIDEBAR_MENU_BUTTON).click
    # Se añade una espera explícita para asegurar que el menú se ha abierto
    # antes de intentar hacer clic en el enlace de logout.
    find(LOGOUT_LINK, wait: 5).click
  end

  # Obtiene la cantidad de items que se muestra sobre el ícono del carrito
  def cart_badge_count
    # Si el contador no existe (ej. carrito vacío), devuelve 0.
    return 0 unless page.has_css?(CART_BADGE)
    find(CART_BADGE).text.to_i
  end

  def on_page?
    has_current_path?(expected_path) && has_css?(TITLE, text: expected_title)
  end
  
  def expected_path

  end
  
  def expected_title
    
  end
end 