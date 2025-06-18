Feature: Product Filtering
  As a shopper
  I want to filter products in different ways
  So I can find what I'm looking for easily

  Background:
    Given I am on the SauceDemo login page
    When I login with username "standard_user" and password "secret_sauce"
    Then I should be redirected to the products page after login

  Scenario: Filter by Name (A to Z)
    When I select the filter "Name (A to Z)"
    And I wait for the products to be sorted
    Then the products should be sorted alphabetically ascending

  Scenario: Filter by Name (Z to A)
    When I select the filter "Name (Z to A)"
    And I wait for the products to be sorted
    Then the products should be sorted alphabetically descending

  Scenario: Filter by Price (low to high)
    When I select the filter "Price (low to high)"
    And I wait for the products to be sorted
    Then the products should be sorted by price ascending

  Scenario: Filter by Price (high to low)
    When I select the filter "Price (high to low)"
    And I wait for the products to be sorted
    Then the products should be sorted by price descending