Feature: Login to Swag Labs
  As a potential shopper
  I want to log into Swag Labs
  So that I can view and buy products

  Background:
    Given I am on the SauceDemo login page

  Scenario: Valid user logs in successfully
    When I login with username "standard_user" and password "secret_sauce"
    Then I should be redirected to the products page after login

  Scenario: Locked-out user cannot log in
    When I login with username "locked_out_user" and password "secret_sauce"
    Then I should see the login error message "Epic sadface: Sorry, this user has been locked out."

  Scenario Outline: Invalid credentials are rejected
    When I login with username "<user>" and password "<pass>"
    Then I should see the login error message "<message>"
    
    Examples:
      | user          | pass         | message                                                                    |
      | invalid_user  | wrong_pass   | Epic sadface: Username and password do not match any user in this service  |
      |               | secret_sauce | Epic sadface: Username is required                                         |
      | standard_user |              | Epic sadface: Password is required                                         |