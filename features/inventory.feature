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