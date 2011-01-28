When /^I vote "([^"]*)" for link (\d+)$/ do |vote, link|
  within_vote(link, vote) do
    click_link vote
  end
end

Then /^I should be able to (up|down)-vote for link (\d+)$/ do |vote, link|
  within_link(link) do
    page.should have_css(".vote .#{vote} a")
  end
end

Then /^I should not be able to (up|down)-vote for link (\d+)$/ do |vote, link|
  within_link(link) do
    page.should_not have_css(".vote .#{vote} a")
  end
end

Then /^I should see "(\d+)" as the value for link (\d+)$/ do |total, link|
  within_link(link) do
    within(".value") do
      page.should have_content(total)
    end
  end
end
