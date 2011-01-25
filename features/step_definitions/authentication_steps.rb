When /^I am logged in as "(\w+)"$/ do |username|
  user = User.where(:username => username)
  User.create(:username => username, :password => 'password', :password_confirmation => 'password') unless user.length > 0

  visit path_to("the login page")
  fill_in 'Username', :with => username
  fill_in 'Password', :with => 'password'
  click_button 'Login'
end