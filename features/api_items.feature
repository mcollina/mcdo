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
        "name": "Insert your items!",
        "position": 0
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
      "list_link": "http://www.example.com/lists/1",
      "position": 1
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
        "name": "Insert your items!",
        "position": 0
      }, {
        "name": "foobar",
        "position": 1
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
      "list_link": "http://www.example.com/lists/1",
      "position": 0
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
      "list_link": "http://www.example.com/lists/1",
      "position": 0
    }
    """

  Scenario: Moving an element to the top
    Given I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
        "name": "b"
      }
    }
    """
    And I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
        "name": "c"
      }
    }
    """
    When I call "/lists/1/items/2/move.json" in PUT with:
    """
    {
      "position": 0
    }
    """
    Then the JSON should be:
    """
    {
      "items": [{
        "name": "b",
        "position": 0
      }, {
        "name": "Insert your items!",
        "position": 1
      }, {
        "name": "c",
        "position": 2
      }],
      "list_link": "http://www.example.com/lists/1"
    }
    """

  Scenario: Moving an element to the middle
    Given I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
        "name": "b"
      }
    }
    """
    And I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
        "name": "c"
      }
    }
    """
    When I call "/lists/1/items/3/move.json" in PUT with:
    """
    {
      "position": 1
    }
    """
    Then the JSON should be:
    """
    {
      "items": [{
        "name": "Insert your items!",
        "position": 0
      }, {
        "name": "c",
        "position": 1
      }, {
        "name": "b",
        "position": 2
      }],
      "list_link": "http://www.example.com/lists/1"
    }
    """

  Scenario: Moving an element to the end
    Given I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
        "name": "b"
      }
    }
    """
    And I call "/lists/1/items.json" in POST with:
    """
    {
      "item": {
        "name": "c"
      }
    }
    """
    When I call "/lists/1/items/1/move.json" in PUT with:
    """
    {
      "position": 2
    }
    """
    Then the JSON should be:
    """
    {
      "items": [{
        "name": "b",
        "position": 0
      }, {
        "name": "c",
        "position": 1
      }, {
        "name": "Insert your items!",
        "position": 2
      }],
      "list_link": "http://www.example.com/lists/1"
    }
    """
