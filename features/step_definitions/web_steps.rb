When /^I call "([^"]*)" in (GET|POST|PUT|DELETE) with:$/ do |path, method, json|
  # this is not supported by all drivers
  page.driver.send(method.downcase, path, JSON.parse(json))
end

Then /^I should see a link to "([^"]*)" titled "([^"]*)"$/ do |url, text|
  page.should have_xpath("//a[text()='#{text}' and @href='#{url}']")
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end
