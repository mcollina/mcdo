Given /^there is the following user:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each { |u| User.create! u }
end

Given /^I login succesfully$/ do
  User.create! email: "aa@abc.org", password: "1234", password_confirmation: "1234"
  page.driver.post("/session.json", email: "aa@abc.org", password: "1234")
end
