Given /^there is the following user:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each { |u| User.create! u }
end
