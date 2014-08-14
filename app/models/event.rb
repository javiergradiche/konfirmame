class Event < ActiveRecord::Base
	
	include IceCube
	serialize :recurring_rule

  attr_accessor :schedule

	has_many :event_occurrences
	has_many :user_events
	has_many :notifications
	has_many :users, :through => :user_events

	validate :has_valid_recurring_rule
	validates :name, presence: true
  validates :aforo, presence: true
  validates :start_date, presence: true
	validates :recurring_rule, presence: true
	validates :state, presence: true
	validates :first_call, :rush_start, :call_hour, presence: true

	after_save :update_occurrences
  before_save :update_start_date

  #CALLBACK
  def update_start_date
    
  end

  #USERS
  def add_user(user)
  	unless user.has_event?(self)
  		user_event = self.user_events.create(:user => user, :state => 'active')
      user_event.update_notifications
    end
    user_event
  end

  def remove_user(user)
  	if user.has_event?(self)
  		UserEvent.where(:user => user, :event => event).destroy_all
  	end
  end

  #OCCURRENCES
	def has_valid_recurring_rule
    # bindiny.pry
     # errors.add(:recurring_rule, "is not valid") unless  RecurringSelect.is_valid_rule?(self.recurring_rule)
  end
  #
  def schedule=(schedule)
    self.recurring_rule = schedule.to_yaml
  end

  def schedule
    self.schedule = IceCube::Schedule.from_yaml(self.recurring_rule).count()
    self.schedule.start_time(self.start_date)
  end

  def get_schedule_occurrences(quant = nil)
  	if quant
  		self.schedule.first(quant)
  	else
      self.schedule.all_occurrences
  	end
  end

  #Callback
  def update_occurrences
    EventOccurrence.next.where(:event => self).destroy_all
    self.schedule.all_occurrences.each do |occurrence|
      event_ocurrence = self.event_occurrences.create(
          :start_datetime => occurrence,
          :aforo => self.aforo,
          :state => 'active',
          :num_confirm => 0
      )
    end
  end

end
