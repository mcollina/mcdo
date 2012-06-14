@signup_app
@javascript
Feature: Signup from the web app
  As a MCDO prospect
  In order to discover the service
  I want to signup for the service

  Background:
    Given I visit the home page

  Scenario: Signup
    When I fill "email" with "aaaa@foobar.com"
    When I fill "password" with "password"
    When I fill "password_confirmation" with "password"
    And I click on "Signup"
    Then I should see "Log out"

  Scenario: No logout before signup/login
    Then I should not see "Log out"
