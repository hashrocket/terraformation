require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^I am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I press "([^\"]*)"$/ do |button, selector|
  click_button(button)
end

When /^I follow "([^\"]*)"$/ do |link, selector|
  click_link(link)
end

When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value, selector|
  fill_in(field, :with => value)
end

When /^I fill in "([^\"]*)" for "([^\"]*)"$/ do |value, field, selector|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^I fill in the following:$/ do |selector, fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^I select "([^\"]*)" from "([^\"]*)"$/ do |value, field, selector|
  select(value, :from => field)
end

When /^I check "([^\"]*)"$/ do |field, selector|
  check(field)
end

When /^I uncheck "([^\"]*)"$/ do |field, selector|
  uncheck(field)
end

When /^I choose "([^\"]*)"$/ do |field, selector|
  choose(field)
end

When /^I attach the file "([^\"]*)" to "([^\"]*)"$/ do |path, field, selector|
  attach_file(field, path)
end

Then /^I should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

Then /^I should see "([^\"]*)"$/ do |text, selector|
  page.should have_content(text)
end

Then /^I should see \/([^\/]*)\/$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  page.should have_xpath('//*', :text => regexp)
end

Then /^I should not see "([^\"]*)"$/ do |text, selector|
  page.should have_no_content(text)
end

Then /^I should not see \/([^\/]*)\/$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  page.should have_no_xpath('//*', :text => regexp)
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, selector, value|
  field = find_field(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  field_value.should =~ /#{value}/
end

Then /^the "([^\"]*)" field should not contain "([^\"]*)"$/ do |field, selector, value|
  field = find_field(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  field_value.should_not =~ /#{value}/
end

Then /^the "([^\"]*)" checkbox should be checked$/ do |label, selector|
  field_checked = find_field(label)['checked']
  field_checked.should == 'checked'
end

Then /^the "([^\"]*)" checkbox should not be checked$/ do |label, selector|
  field_checked = find_field(label)['checked']
  field_checked.should_not == 'checked'
end

Then /^I should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then /^I should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  actual_params.should == expected_params
end

Then /^show me the page$/ do
  save_and_open_page
end
