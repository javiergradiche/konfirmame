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
    where('notifications.state in (?)', ['pending','sent','opened'])
    .where('notifications.start_datetime <= (?)', now)
    .where('notifications.end_datetime >= (?)', now)
  }

  #states => [:pending, :sent, :opened, :confirmed, :rejected]
  # def time_to_notify(datetime)
  #   NotificationMailer.ask_confirmation('javiergradiche@gmail.com','body content').deliver
  # end

  def rush_hour?(datetime = Time.now)
    if (self.rush_start?) #si no tiene rush_start no tiene rush
      ((datetime >= self.rush_start) && (datetime <= self.end_datetime))
    else
      false
    end
  end

  def shippable?(datetime = Time.now)
    if ((datetime >= self.start_datetime) && (datetime <= self.end_datetime))
      if (datetime.hour == self.event.call_hour)
        true #es la hora de envio
      else
        #esta dentro del dia pero no la hora, verifico si esta en rush
        self.rush_hour?(datetime)
      end
    else
      false #no esta dentro del rango de dias
    end
  end

  def send!
    NotificationMailer.ask_confirmation_mandrill(self).deliver
    self.state = 'sent'
    self.last_shipping = Time.now
    self.save
  end

  def self.get_shippables(datetime)
    notifications = Notification.shippable(datetime)
    shippable_notifications = []
    notifications.each do |notification|
      if notification.shippable?(datetime)
        notification.send!
        shippable_notifications << notification
      end
    end
    shippable_notifications
  end

  def update_state!(state)
    self.state = state
    unless (self.event_occurrence.add_confirmation!)
      self.state = 'denied'
    end
    self.save
  end

end
