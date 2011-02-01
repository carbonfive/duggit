When /^I vote (up|down) "([^"]*)"$/ do |vote, link|
  within_link link do
    click_link vote
  end
end

Then /^I should see "([^"]*)" as the value for "([^"]*)"$/ do |value, link|
  within_link link do
    page.should have_css('.value', :text => value)
  end
end

Then /^I should be able to (up|down)-vote "([^"]*)"$/ do |vote, link|
  within_link link do
    page.should have_css("a", :text => vote)
  end
end

Then /^I should not be able to (up|down)-vote "([^"]*)"$/ do |vote, link|
  within_link link do
    page.should_not have_css("a", :text => vote)
  end
end
