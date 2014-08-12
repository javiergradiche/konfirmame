# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_occurrence do
    event
    start_datetime "2014-08-09 13:39:17"
    state "MyString"
    aforo 10
    num_confirm 0
  end
end
