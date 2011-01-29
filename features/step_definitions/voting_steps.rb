When /^I vote (up|down) "([^"]*)"$/ do |vote, link|
  click_link vote
end

Then /^I should see "([^"]*)" as the value for "([^"]*)"$/ do |value, link|
  page.should have_css('.value', :text => value)
end

Then /^I should be able to (up|down)-vote "([^"]*)"$/ do |vote, link|
  page.should have_css(".vote .#{vote} a")
end

Then /^I should not be able to (up|down)-vote "([^"]*)"$/ do |vote, link|
  page.should_not have_css(".vote .#{vote} a")
end

