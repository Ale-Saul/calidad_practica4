Feature: Checkout process

  As a shopper
  I want to buy the products in my cart
  So I can complete my purchase and receive my order

  Background: Login and add a product to the cart
    Given I am on the SauceDemo login page
    When I enter username "standard_user"
    And  I enter password "secret_sauce"
    And  I click the login button
    Then I should be redirected to the products page
    When I add the first product to the cart
