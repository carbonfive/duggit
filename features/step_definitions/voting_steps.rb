When /^I vote (up|down) "([^"]*)"$/ do |vote, link|
  link = Link.find_by_title! link
  within "li#link_#{link.id}" do
    click_link vote
  end
end

Then /^I should see "([^"]*)" as the value for "([^"]*)"$/ do |value, link|
  link = Link.find_by_title! link
  with_scope "li#link_#{link.id}" do
    page.should have_content(value)
  end
end

Then /^I should be able to (up|down)-vote "([^"]*)"$/ do |vote, link|
  link = Link.find_by_title! link
  with_scope "li#link_#{link.id}" do
    page.should have_css("a", :text => vote)
  end
end

Then /^I should not be able to (up|down)-vote "([^"]*)"$/ do |vote, link|
  link = Link.find_by_title! link
  with_scope "li#link_#{link.id}" do
    page.should_not have_css("a", :text => vote)
  end
end
