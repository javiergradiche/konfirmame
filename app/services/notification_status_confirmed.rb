class NotificationStatusConfirmed < NotificationStatus

  def send_mail(notification)
    NotificationMailer.notify_confirmed(notification).deliver
    puts "Mail Type Confirmed"
  end

  def state
    'confirmed'
  end

end