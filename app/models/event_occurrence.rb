class EventOccurrence < ActiveRecord::Base

	belongs_to :event
  has_many :notifications
  has_many :user_events, :through => :event

	validates :event_id, :start_datetime, :aforo, :num_confirm, :state, presence: true

	scope :next, -> { where('event_occurrences.start_datetime > ?', Time.now) }

  def rush_start
    if self.event.rush_start?
      (self.start_datetime - (self.event.rush_start).hours)
    else
      nil
    end
  end

  def full?
    self.aforo <= self.num_confirm
  end

  def add_confirmation!
    if self.full?
      false
    else
      self.num_confirm += 1
      self.save
      true
    end
  end

  def update_confirmations!
    self.num_confirm = self.notifications.where(:state => 'confirmed').sum(1)
    self.save
  end

end
