Feature: Inventory Management

    As a potential shopper
    I want to interact with the product inventory
    So that I can view and sort available products

    Background:
        Given I am on the Swag Labs login page
        When I log in with valid credentials
        Then I should see the product inventory page

    Scenario: Viewing all products
        Given I am on the product inventory page
        Then I should see a list of available products

    Scenario: Sorting products by name (A to Z)
        Given I am on the product inventory page
        When I sort the products by "Name (A to Z)"
        Then the products should be sorted alphabetically from A to Z

    Scenario: Sorting products by name (Z to A)
        Given I am on the product inventory page
        When I sort the products by "Name (Z to A)"
        Then the products should be sorted alphabetically from Z to A

    Scenario: Sorting products by price (low to high)
        Given I am on the product inventory page
        When I sort the products by "Price (low to high)"
        Then the products should be sorted by price from lowest to highest

    Scenario: Sorting products by price (high to low)
        Given I am on the product inventory page
        When I sort the products by "Price (high to low)"
        Then the products should be sorted by price from highest to lowest

    Scenario: Viewing product details
        Given I am on the product inventory page
        When I click on the "Sauce Labs Backpack" product
        Then I should be taken to the product detail page for "Sauce Labs Backpack"