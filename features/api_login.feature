@login
Feature: Login API
  As a MCDO developer
  In order to develop apps
  I want to login with an existing user

  Background:
    Given there is the following user:
      | email       | password | password_confirmation |
      | abcd@org.it | aa       | aa                    |

  Scenario: Succesful login
    When I call "/session.json" in POST with:
    """
    {
      "email": "abcd@org.it",
      "password": "aa"
    }
    """
    Then the JSON should be:
    """
    {
      "status": "authenticated"
    }
    """

  Scenario: Failed login
    When I call "/session.json" in POST with:
    """
    {
      "email": "abcd@org.it",
      "password": "bb"
    }
    """
    Then the JSON should be:
    """
    {
      "status": "not authenticated"
    }
    """

  Scenario: Validating an active session
    Given I call "/session.json" in POST with:
    """
    {
      "email": "abcd@org.it",
      "password": "aa"
    }
    """
    When I call "/session.json" in GET
    Then the JSON should be:
    """
    {
      "status": "authenticated"
    }
    """

  Scenario: Validating a wrong session
    When I call "/session.json" in GET
    Then the JSON should be:
    """
    {
      "status": "not authenticated"
    }
    """

  Scenario: Logout
    Given I call "/session.json" in POST with:
    """
    {
      "email": "abcd@org.it",
      "password": "aa"
    }
    """
    When I call "/session.json" in DELETE
    Then the JSON should be:
    """
    {
      "status": "not authenticated"
    }
    """
