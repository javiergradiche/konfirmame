class UserEvent < ActiveRecord::Base

	belongs_to :user
	belongs_to :event
  has_many :event_occurrences, :through => :event

	validates :event_id, presence: true
	validates :user_id, presence: true
	validates :state, presence: true
	
	# include AASM
  # aasm :column => 'state' do

  # end

  def update_notifications
    Notification.next.where(:user => self.user, :event => self.event).destroy_all
    self.event_occurrences.each do |occurrence|
      notification = occurrence.notifications.create(
        :user_id => self.user_id,
        :event_id => self.event_id,
        :start_datetime => (occurrence.start_datetime - (self.event.first_call).days),
        :end_datetime => occurrence.start_datetime,
        :state => 'pending',
        :rush_start => (occurrence.start_datetime - (self.event.rush_start).hours)
      )
    end
  end

end
