Feature: Login to Swag Labs
  As a potential shopper
  I want to log into Swag Labs
  So that I can view and buy products

  Background: Landing on the login page
    Given I am on the SauceDemo login page

  Scenario: Valid user logs in successfully
    When I enter username "standard_user"
    And  I enter password "secret_sauce"
    And  I click the login button
    Then I should be redirected to the products page

