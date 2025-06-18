class LoginPage < BasePage
  USERNAME_INPUT = '[data-test="username"]'
  PASSWORD_INPUT = '[data-test="password"]'
  LOGIN_BUTTON = '[data-test="login-button"]'
  ERROR_MESSAGE = '[data-test="error"]'

  def visit_page
    visit('/')
    expect(page).to have_css(LOGIN_BUTTON)
  end

  def login_with(username, password)
    find(USERNAME_INPUT).set(username) if username
    find(PASSWORD_INPUT).set(password) if password
    find(LOGIN_BUTTON).click
  end

  def error_message_text
    find(ERROR_MESSAGE).text
  rescue Capybara::ElementNotFound
    ''
  end
end