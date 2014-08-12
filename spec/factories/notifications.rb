# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  start_futbol = Time.utc(2014, 4, 13, 16, 0)

  factory :notification do
    event
    event_occurrence
    user
    state "pending"
    comment "MyText"
    start_datetime start_futbol - 4.days
    end_datetime start_futbol - 1.hours
    last_shipping nil
    rush_start start_futbol - 4.hours
  end
end
