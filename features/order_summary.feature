Feature: Checkout Overview - Order Summary
  As a customer
  I want to review the order summary before finalizing my purchase
  So that I can verify product details, prices, and confirm the total amount

  Background:
    Given I am a logged-in user
    And I have added the product "Sauce Labs Backpack" to the cart
    And I proceed to checkout and complete my information
    And I am on the "Checkout: Overview" page

  Scenario: Order summary displays correct title and structure
    Then I should see a title with text "Checkout: Overview"
    And the title should be inside a container with class "header_secondary_container" and data-test "secondary-header"
    And the container should be inside a div with ID "checkout_summary_container"

  Scenario: Display of product details in order summary
    Then I should see a product listed with:
      | Quantity | Name                | Description                                              | Price   |
      | 1        | Sauce Labs Backpack | carry.allTheThings() with the sleek, streamlined Sly Pack | $29.99 |
    And the product name should be a link to the item detail page
    And the product container should have the class "cart_item" and data-test "inventory-item"

  Scenario: Display of subtotal, tax and total price
    Then I should see the payment method as "SauceCard #31337"
    And I should see the shipping method as "Free Pony Express Delivery!"
    And I should see a subtotal labeled "Item total: $29.99"
    And I should see a tax labeled "Tax: $2.40"
    And I should see a total labeled "Total: $32.39"

  Scenario: Action buttons are available
    Then I should see a "Finish" button with data-test "finish"
    And I should see a "Cancel" button with data-test "cancel"

  Scenario: User completes the order
    When I click the "Finish" button
    Then I should be redirected to the checkout "Complete!" page
    And I should see the message "THANK YOU FOR YOUR ORDER"
    
  Scenario: User cancels the order
    When I click the "Cancel" button
    Then I should be redirected back to the inventory page
    And the cart should still contain the item

  Scenario: Element visibility and data-test attributes
    Then all major elements should have appropriate data-test attributes:
      | Element           | Data-test                  |
      | Order container   | checkout-summary-container |
      | Product container | inventory-item             |
      | Title             | title                      |
      | Cart list         | cart-list                  |

  Scenario: Price calculation is consistent
    Given the item price is $29.99 and tax is $2.40
    Then the total price should be $32.39