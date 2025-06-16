@login
Feature: Inventory Management

  As a potential shopper
  I want to interact with the product inventory
  So that I can view and sort available products

  Background:
    Given I am on the product inventory page

  Scenario: Viewing the inventory page
    Then I should see the inventory title as "Products"
    And I should see the following products:
      | Name                              | Price  |
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Sauce Labs Fleece Jacket          | $49.99 |
      | Sauce Labs Onesie                 | $7.99  |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |

  Scenario: Sorting products by name (A to Z)
    When I select "Name (A to Z)" from the sort dropdown
    Then I should see the following sorted products:
      | Name                              |
      | Sauce Labs Backpack               |
      | Sauce Labs Bike Light             |
      | Sauce Labs Bolt T-Shirt           |
      | Sauce Labs Fleece Jacket          |
      | Sauce Labs Onesie                 |
      | Test.allTheThings() T-Shirt (Red) |

  Scenario: Sorting products by name (Z to A)
    When I select "Name (Z to A)" from the sort dropdown
    Then I should see the following sorted products:
      | Name                              |
      | Test.allTheThings() T-Shirt (Red) |
      | Sauce Labs Onesie                 |
      | Sauce Labs Fleece Jacket          |
      | Sauce Labs Bolt T-Shirt           |
      | Sauce Labs Bike Light             |
      | Sauce Labs Backpack               |

  Scenario: Sorting products by price (low to high)
    When I select "Price (low to high)" from the sort dropdown
    Then I should see the following sorted products by price:
      | Name                              | Price  |
      | Sauce Labs Onesie                 | $7.99  |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Fleece Jacket          | $49.99 |

  Scenario: Sorting products by price (high to low)
    When I select "Price (high to low)" from the sort dropdown
    Then I should see the following sorted products by price:
      | Name                              | Price  |
      | Sauce Labs Fleece Jacket          | $49.99 |
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Onesie                 | $7.99  |

  Scenario: Viewing product details
    When I click on the product name "Sauce Labs Backpack"
    Then I should be on the product details page for "Sauce Labs Backpack"
    And the product price should be "$29.99"
    And the product description should be visible