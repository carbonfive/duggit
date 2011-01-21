When /^I am logged in as "(\w+)" with password "(\w+)"$/ do |username, password|
  visit path_to("the login page")
  fill_in 'Username', :with => 'mwynholds'
  fill_in 'Password', :with => 'password'
  click_button 'Login'
end