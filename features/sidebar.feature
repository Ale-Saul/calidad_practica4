Feature: Sidebar Menu Functionality
  As a registered user
  I want to use the sidebar menu
  So I can navigate to different sections or perform actions like logout and reset.

  Background: User is logged in and on the products page
    Given I am on the SauceDemo login page
    When I enter username "standard_user"
    And I enter password "secret_sauce"
    And I click the login button
    Then I should be redirected to the products page
    And I open the sidebar menu

  Scenario: Navigate to All Items
    When I click "All Items" in the sidebar
    Then I should be redirected to the products page
    And the sidebar menu should be closed