Feature: User registration
  So that I can participate in the site
  As an anonymous user
  I can register for an account

  Scenario: Register an account
    When I go to the registration page
    And I fill in "username" with "mwynholds"
    And I fill in "password" with "password"
    Then I should see "welcome mwynholds"