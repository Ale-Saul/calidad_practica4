Feature: Product Filtering
  As a shopper
  I want to filter products in different ways
  So I can find what I'm looking for easily

  Background:
    Given I am on the SauceDemo login page
    When I enter username "standard_user"
    And I enter password "secret_sauce"
    And I click the login button
    Then I should be redirected to the products page

  Scenario: Test all filter options
    When I select the filter "Name (A to Z)"
    Then the products should be sorted alphabetically ascending
    When I select the filter "Name (Z to A)"
    Then the products should be sorted alphabetically descending
    When I select the filter "Price (low to high)"
    Then the products should be sorted by price ascending
    When I select the filter "Price (high to low)"
    Then the products should be sorted by price descending