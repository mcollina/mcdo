Then /^I should see a link to "([^"]*)" titled "([^"]*)"$/ do |url, text|
  page.should have_xpath("//a[text()='#{text}' and @href='#{url}']")
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end
