# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_event do
  	user
  	event
  	state "active"
  end
end
