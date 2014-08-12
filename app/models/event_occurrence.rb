class EventOccurrence < ActiveRecord::Base

	belongs_to :event
  has_many :notifications
  has_many :user_events, :through => :event

	validates :event_id, presence: true

	scope :next, -> { where('event_occurrences.start_datetime > ?', Time.now) }

end
