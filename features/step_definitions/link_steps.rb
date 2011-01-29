Then /^I should see the links in the following order: "([^"]*)", "([^"]*)", "([^"]*)"$/ do |first, second, third|
  page.should have_css('ol li:nth-child(1)', :text => first)
  page.should have_css('ol li:nth-child(2)', :text => second)
  page.should have_css('ol li:nth-child(3)', :text => third)
end
