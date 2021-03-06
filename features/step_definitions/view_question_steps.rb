Given /^I logged in as an? "(\w+)"$/ do |kind|
  user = FactoryGirl.create kind
  visit "/users/sign_in"
  fill_in :user_email, with: user.email
  fill_in :user_password, with: "testpassword"
  click_button "Sign in"
end

When /^I am on the "(.*?)" questions list page$/ do |group_name|
  g = Group.where(name: group_name).first
  visit group_questions_path(g)
end

When /^I follow "(.*?)"$/ do |question_title|
  click_link question_title
end

When /^I follow first link "(.*?)"$/ do |question_title|
  page.first(:xpath, "//a[contains(text(), 'Review')]").click
end

Then /^I should( not)? see:? "(.*?)"$/ do |negation, text|
  if negation
    page.should have_no_content(text)
  else
    page.should have_content(text)
  end
end

Then /^I should see button: "(.*?)"$/ do |text|
  page.should have_button(text)
end

Then /^I should not see button: "(.*?)"$/ do |text|
  page.should_not have_button(text)
end

Given /^I subscribed "([^"]*)" question category/ do |category|
  User.count.should == 1
  u = User.last
  u.groups << [Group.find_by_name(category)]
  u.save!
end
