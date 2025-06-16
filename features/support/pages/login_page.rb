class LoginPage < BasePage
  # --- Selectores ---
  USERNAME_INPUT = '[data-test="username"]'
  PASSWORD_INPUT = '[data-test="password"]'
  LOGIN_BUTTON = '[data-test="login-button"]'
  ERROR_MESSAGE = '[data-test="error"]'

  def visit_page
    visit('/')
  end

  def login_with(username, password)
    find(USERNAME_INPUT).set(username) if username
    find(PASSWORD_INPUT).set(password) if password
    # El botón de login en la UI no tiene un data-test, por eso lo buscamos por su texto.
    # Si lo tuviera, sería más robusto usar: find(LOGIN_BUTTON).click
    click_button('Login')
  end

  def error_message_text
    find(ERROR_MESSAGE).text
  end
end 