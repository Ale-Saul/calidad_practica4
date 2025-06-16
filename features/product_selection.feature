@login
Feature: Product Selection Management
  As a shopper
  I want to select and manage multiple products
  So I can choose what I want to buy

  Background:
    Given I am on the product inventory page

  Scenario: Add all available products to the cart
    When I add every available item to the cart
    Then the cart icon should show a badge with the correct number of items

  Scenario: Remove all products from the cart after adding them
    Given I have added every available item to the cart
    When I remove every item from the cart
    Then the cart icon badge should disappear