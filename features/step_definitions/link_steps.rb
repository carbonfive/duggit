Then /^I should see the following links in order:$/ do |table|
  table.hashes.each_with_index do |link, index|
    page.should have_css("ol li:nth-child(#{index + 1})", :text => link[:title])
  end
end
