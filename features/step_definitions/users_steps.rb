Given /^there is the following user:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each { |u| User.create! u }
end

Given /^I login succesfully with user "([^"]*)"$/ do |email|
  # if this calls go bad there is already a user, but
  # it's not a problem if has been created with password 1234.
  User.create email: email, password: "1234", password_confirmation: "1234"
  page.driver.post("/session.json", email: email, password: "1234")
end

Given /^I logout$/ do
  header "content_type", "application/json"
  page.driver.delete "/session"
end
