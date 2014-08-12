class Notification < ActiveRecord::Base

	belongs_to :user
	belongs_to :event_occurrence
	belongs_to :event

	validates :event_id, presence: true
	validates :user_id, presence: true
	validates :event_occurrence_id, presence: true
	validates :start_datetime, :end_datetime, presence: true

  scope :next, -> { where('notifications.start_datetime > ?', Time.now) }

  scope :shippable, -> (now) {
    where('notifications.state in (?)', ['pending','send','open'])
    .where('notifications.start_datetime > (?)', now)
    .where('notifications.end_datetime < (?)', now)
  }

  #states => [:pending, :sent, :opened, :confirmed, :rejected]
  def time_to_notify(datetime)
    NotificationMailer.ask_confirmation('javiergradiche@gmail.com','body content').deliver
  end

  def rush_hour?
    if (self.rush_start?) #si no tiene rush_start no tiene rush
      now = Time.now
      ((now > self.rush_start) && (now < self.end_datetime))
    else
      false
    end
  end

  def shippable?
    now = Time.now
    if ((now > self.rush_start) && (now < self.end_datetime))
      if (now.hour == self.event.call_hour)
        true #es la hora de envio
      else
        #esta dentro del dia pero no la hora, verifico si esta en rush
        self.rush_hour?
      end
    else
      false #no esta dentro del rango de dias
    end
  end

  def send!
    NotificationMailer.create_ask_confirmation_mandrill(self.user).deliver
    self.state = 'sent'
  end

  def self.get_shippables(datetime)
    notifications = Notification.shippable(datetime)
    notifications.each do |notification|
      if notification.shippable?
        notification.send!
      end
    end
  end


end
