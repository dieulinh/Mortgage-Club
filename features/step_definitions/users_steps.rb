When(/^I click "(.*?)"/) do |link|
  click_link(link)
end

# Transform(/^(-?\d+)$/).map(&:to_i)
Transform(/^(-?\d+)$/) do |number|
  number.to_i
end
