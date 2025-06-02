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

  Scenario: Navigate to About page
    When I click "About" in the sidebar
    Then I should be redirected to the "https://saucelabs.com/" page
    # Note: We might need to adjust the assertion if the "About" link goes elsewhere or opens a new tab.
    # For now, let's assume it navigates in the current tab.
    # And I close the sidebar menu (if it's still open on the new page)

  Scenario: Logout from the application
    When I click "Logout" in the sidebar
    Then I should be redirected to the login page
    And the sidebar menu should be closed (or not present on login page)

  Scenario: Reset App State
    # First, add an item to the cart to verify reset works
    When I add the first product to the cart from the products page
    And I open the sidebar menu # Re-open if adding item closes it or navigates away
    And I click "Reset App State" in the sidebar
    Then the cart should be empty
    And I should be on the products page
    And the sidebar menu should be closed 