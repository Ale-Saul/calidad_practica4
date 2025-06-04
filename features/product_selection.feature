Feature: Product Selection Management
  As a shopper
  I want to select and manage multiple products
  So I can choose what I want to buy

  Background:
    Given I am on the SauceDemo login page
    When I enter username "standard_user"
    And I enter password "secret_sauce"
    And I click the login button
    Then I should be redirected to the products page

  Scenario: Select and remove multiple products
    When I add all products to the cart
    Then the cart badge should show the total number of products
    When I remove all products from the cart
    Then the cart badge should be empty