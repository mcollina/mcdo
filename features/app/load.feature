@load_app
Feature: Show the index page
  As a MCDO prospect
  In order to discover the service
  I want to see the main page

  Scenario: Show the MCDO name
    When I visit the home page
    Then I should see "MCDO"
  
  Scenario: Show a link to matteocollina.com
    When I visit the home page
    Then I should see a link to "http://matteocollina.com" titled "Matteo Collina"
