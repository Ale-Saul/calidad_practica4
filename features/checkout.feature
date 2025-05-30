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

  Scenario: Successful checkout with valid data
    When I go to the cart
    And I click the checkout button
    And I fill in my information with first name "Juan", last name "Pérez", and postal code "12345"
    And I continue to the overview
    And I finish the purchase
    Then I should see the confirmation message "Thank you for your order!"