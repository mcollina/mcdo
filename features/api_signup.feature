Feature: Signup API
  As a MCDO developer
  In order to develop apps
  I want to register new users

  Scenario: Succesful signup
    When I call "/users.json" in POST with:
    """
    {
      "user": {
        "email": "hello@abc.org",
        "password": "abcde",
        "password_confirmation": "abcde"
      }
    }
    """
    Then the JSON should be:
    """
    {
      "id": 1,
      "email": "hello@abc.org"
    }
    """

  Scenario: signup fails without an email
    When I call "/users.json" in POST with:
    """
    {
      "user": {
        "email": "",
        "password": "abcde",
        "password_confirmation": "abcde"
      }
    }
    """
    Then the JSON should be:
    """
    {
      "errors": { "email": ["can't be blank"] }
    }
    """

  Scenario: signup fails without a password
    When I call "/users.json" in POST with:
    """
    {
      "user": {
        "email": "hello@abc.org",
        "password": "",
        "password_confirmation": ""
      }
    }
    """
    Then the JSON should be:
    """
    {
      "errors": { 
        "password": ["can't be blank"],
        "password_digest": ["can't be blank"] 
      }
    }
    """

  Scenario: signup fails with a wrong password_confirmation
    When I call "/users.json" in POST with:
    """
    {
      "user": {
        "email": "hello@abc.org",
        "password": "abcde",
        "password_confirmation": "abcde1"
      }
    }
    """
    Then the JSON should be:
    """
    {
      "errors": { "password": ["doesn't match confirmation"] }
    }
    """

  Scenario: Impossible to signup two users with the same email
    Given I call "/users.json" in POST with:
    """
    {
      "user": {
        "email": "hello@abc.org",
        "password": "abcde",
        "password_confirmation": "abcde"
      }
    }
    """
    When I call "/users.json" in POST with:
    """
    {
      "user": {
        "email": "hello@abc.org",
        "password": "abcde",
        "password_confirmation": "abcde"
      }
    }
    """
    Then the JSON should be:
    """
    {
      "errors": { "email": ["has already been taken"] }
    }
    """
