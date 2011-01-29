Given /^I am a registered user$/ do
  steps %q{
    When I go to the registration page
     And I fill in "Username" with "userone"
     And I fill in "Password" with "password"
     And I fill in "Confirm" with "password"
     And I press "Register"
    Then I should be on the home page 
     And I should see "Welcome userone"
  }
end

Given /^I am logged in as "([^"]*)"$/ do |credentials|
  username, password = credentials.split '/'
  steps %Q{
    When I go to the login page
     And I fill in "Username" with "#{username}"
     And I fill in "Password" with "#{password}"
     And I press "Login"
  }
end
