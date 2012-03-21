Feature: Lists API
  As a MCDO developer
  In order to develop apps
  I want to manage a user's lists

  Background:
    Given I login succesfully with user "aaa@abc.org"

  Scenario: Default lists
    When I call "/lists.json" in GET
    Then the JSON should be:
    """
    {
      "lists": [{
        "id": 1,
        "name": "Personal",
        "link": "http://www.example.com/lists/1"
      }]
    }
    """

  Scenario: Not authenticated error if not logged in
    Given I logout
    When I call "/lists.json" in GET
    Then the status code should be 403

  Scenario: Removing a list
    When I call "/lists/1.json" in DELETE
    Then the status code should be 204

  Scenario: Removing a list (and the index is empty)
    Given I call "/lists/1.json" in DELETE
    When I call "/lists.json"
    Then the JSON should be:
    """
    {
      "lists": []
    }
    """

  Scenario: Creating a list
    When I call "/lists.json" in POST with:
    """
    {
      "list": {
        "name": "foobar"
      }
    }
    """
    Then the JSON should be:
    """
    {
      "name": "foobar"
    }
    """

  Scenario: A list should have a name
    When I call "/lists.json" in POST with:
    """
    {
      "list": {
        "name": ""
      }
    }
    """
    Then the JSON should be:
    """
    {
      "errors": { "name": ["can't be blank"] }
    }
    """

  Scenario: Creating a list should add it to the index
    Given I call "/lists.json" in POST with:
    """
    {
      "list": {
        "name": "foobar"
      }
    }
    """
    When I call "/lists.json" in GET
    Then the JSON should be:
    """
    {
      "lists": [{
        "id": 2,
        "name": "foobar",
        "link": "http://www.example.com/lists/2"
      }, {
        "id": 1,
        "name": "Personal",
        "link": "http://www.example.com/lists/1"
      }]
    }
    """

  Scenario: Showing a list
    When I call "/lists/1.json" in GET
    Then the JSON should be:
    """
    {
      "name": "Personal"
    }
    """

  Scenario: Updating a list's name
    When I call "/lists/1.json" in PUT with:
    """
    {
      "list": {
        "name": "foobar"
      }
    }
    """
    Then the JSON should be:
    """
    {
      "name": "foobar"
    }
    """

  Scenario: Removing a list and logging in with another user should show his lists
    Given I call "/lists/1.json" in DELETE
    And I logout
    And I login succesfully with user "bbb@abc.org"
    When I call "/lists.json"
    Then the JSON should be:
    """
    {
      "lists": [{
        "id": 2,
        "name": "Personal",
        "link": "http://www.example.com/lists/2"
      }]
    }
    """
