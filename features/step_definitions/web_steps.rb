When /^I call "([^"]*)" in (GET|POST|PUT|DELETE) with:$/ do |path, method, json|
  # this is not supported by all drivers
  page.driver.send(method.downcase, path, JSON.parse(json))
end

When /^I call "([^"]*)" in (GET|POST|PUT|DELETE)$/ do |path, method|
  # this is not supported by all drivers
  page.driver.send(method.downcase, path)
end

When /^I call "([^"]*)"$/ do |path|
  step "I call \"#{path}\" in GET"
end

When /^I fill "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in field, with: value
end


When /^I click on "(.*?)"$/ do |text|
  click_on text
end

Then /^I should see a link to "([^"]*)" titled "([^"]*)"$/ do |url, text|
  page.should have_xpath("//a[text()='#{text}' and @href='#{url}']")
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "(.*?)"$/ do |text|
  page.should_not have_content(text)
end

Then /^the status code should be (\d+)$/ do |code|
  page.driver.status_code.should == code.to_i
end
