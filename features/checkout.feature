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

  Scenario: Checkout fails with empty fields
    When I go to the cart
    And I click the checkout button
    And I continue to the overview
    Then I should see the error message "Error: First Name is required"

  Scenario: Cancel checkout and return to products
    When I go to the cart
    And I click the checkout button
    And I fill in my information with first name "Juan", last name "Pérez", and postal code "12345"
    And I continue to the overview
    And I cancel the purchase
    Then I should be redirected to the products page

  Scenario Outline: Validation of required fields at checkout
    When I go to the cart
    And I click the checkout button
    And I fill in my information with first name "<nombre>", last name "<apellido>", and postal code "<codigo_postal>"
    And I continue to the overview
    Then I should see the error message "<mensaje>"

    Examples:
      | nombre | apellido | codigo_postal | mensaje                        |
      |        | Pérez    | 12345         | Error: First Name is required  |
      | Juan   |          | 12345         | Error: Last Name is required   |
      | Juan   | Pérez    |               | Error: Postal Code is required |