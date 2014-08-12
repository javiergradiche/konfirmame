class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_events
  has_many :notifications
	has_many :events, :through => :user_events

  def has_event?(event)
  	event.user_events.pluck(:user_id).include? self.id
  end

end
