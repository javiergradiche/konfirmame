include IceCube

FactoryGirl.define do

  start = Time.utc(2013, 5, 1)
	schedule_1_time = IceCube::Schedule.new(start, duration: 1.days)
  schedule_2_times = IceCube::Schedule.new(start, duration: 2.days)
  schedule_2_times.add_recurrence_rule IceCube::Rule.daily.count(2)
  schedule_10_weeks = IceCube::Schedule.new(start, duration: 2.days)
  schedule_10_weeks.add_recurrence_rule IceCube::Rule.weekly.count(10)
  start_futbol = Time.utc(2014, 4, 13, 16, 0)
  schedule_futbol = IceCube::Schedule.new(start)
  schedule_futbol.add_recurrence_rule IceCube::Rule.weekly(5)

  factory :event do
    recurring_rule schedule_1_time.to_yaml
  	name "Event Name"
  	aforo 10
  	start_date start
    state 'active'
    last_call 4 #hours
    first_call 4 #days
    call_hour 10 #hour (24hrs)
	  factory :two_times_event do
	  	recurring_rule schedule_2_times.to_yaml
	  	name "Two times"
	  end
	  factory :ten_weeks_event do
	  	recurring_rule schedule_10_weeks.to_yaml
	  	name "10_weeks_event"
    end
    factory :every_saturday do
      start_date start_futbol
      recurring_rule schedule_futbol.to_yaml
      name "every saturday"
    end
  end


end
