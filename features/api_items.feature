Feature: Manage a list's items
  As a developer
  In order to manipulate the list's item
  I want to access them through APIs

  Background:
    Given I login succesfully with user "aaa@abc.org"

  Scenario: Default items
    When I call "/lists/1/items.json" in GET
    Then the JSON should be:
    """
    {
      "items": [{
        "name": "Insert your items!"
      }],
      "list_link": "http://www.example.com/lists/1"
    }
    """

  Scenario: Not authenticated error if not logged in
    Given I logout
    When I call "/lists/1/items.json" in GET
    Then the status code should be 403

  Scenario: Removing an item
    When I call "/lists/1/items/1.json" in DELETE
    Then the status code should be 204

  Scenario: Removing an item (and the list is empty)
    Given I call "/lists/1/items/1.json" in DELETE
    When I call "/lists/1/items.json"
    Then the JSON should be:
    """
    {
      "items": [],
      "list_link": "http://www.example.com/lists/1"
    }
    """

  Scenario: Creating an element
    When I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
        "name": "foobar"
      }
    }
    """
    Then the JSON should be:
    """
    {
      "name": "foobar",
      "list_link": "http://www.example.com/lists/1"
    }
    """

  Scenario: An item should have a name
    When I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
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

  Scenario: Creating an item should add it to the list
    Given I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
        "name": "foobar"
      }
    }
    """
    When I call "/lists/1/items.json" in GET
    Then the JSON should be:
    """
    {
      "items": [{
        "name": "Insert your items!"
      }, {
        "name": "foobar"
      }],
      "list_link": "http://www.example.com/lists/1"
    }
    """

  Scenario: Showing an item
    When I call "/lists/1/items/1.json" in GET
    Then the JSON should be:
    """
    {
      "name": "Insert your items!",
      "list_link": "http://www.example.com/lists/1"
    }
    """

  Scenario: Updating an item's name
    When I call "/lists/1/items/1.json" in PUT with:
    """
    {
      "item": {
        "name": "foobar"
      }
    }
    """
    Then the JSON should be:
    """
    {
      "name": "foobar",
      "list_link": "http://www.example.com/lists/1"
    }
    """
