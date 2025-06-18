Feature: Checkout Process

  As a shopper
  I want to complete my purchase
  So I can receive the products I selected

  Background: 
    Given I am logged in as standard user
    And I have added one product to my cart

  # ----- Flujo principal -----
  Scenario: Complete purchase successfully
    When I proceed to checkout with:
      | First Name | Juan  |
      | Last Name  | Pérez |
      | Zip Code   | 12345 |
    And I complete the purchase
    Then I should see the order confirmation

  # ----- Validaciones -----
  Scenario Outline: Validate required checkout fields
    When I attempt checkout with:
      | First Name | <first> |
      | Last Name  | <last>  |
      | Zip Code   | <zip>   |
    Then I should see the error "<error>"

    Examples:
      | first | last  | zip   | error                             |
      |       | Pérez | 12345 | Error: First Name is required     |
      | Juan  |       | 12345 | Error: Last Name is required      |
      | Juan  | Pérez |       | Error: Postal Code is required    |

  # ----- Flujos alternativos -----
  Scenario: Cancel checkout from information page
    When I start checkout process
    And I cancel from information page
    Then I should return to my cart

  Scenario: Cancel checkout from overview page
    When I proceed to checkout with:
      | First Name | Maria |
      | Last Name  | Gomez |
      | Zip Code   | 10101 |
    And I cancel the order
    Then I should return to products page

  # ----- Casos especiales -----
  Scenario: Verify order total with multiple products
    Given I have added two products to my cart
    When I proceed to checkout with:
      | First Name | Carlos |
      | Last Name  | Ruiz   |
      | Zip Code   | 55555  |
    Then the order summary should show correct total

  Scenario: Attempt checkout with empty cart
    Given I have removed all products from cart
    When I attempt to start checkout
    Then I should remain on cart page

  Scenario: Modify information during checkout
    When I start checkout process
    And I enter initial checkout information:
      | First Name | Original |
      | Last Name  | User     |
      | Zip Code   | 10001    |
    And I review order summary
    And I return to information page
    And I modify information with:
      | First Name | Changed |
      | Last Name  | Name    |
      | Zip Code   | 20002   |
    And I complete the purchase
    Then I should see the order confirmation