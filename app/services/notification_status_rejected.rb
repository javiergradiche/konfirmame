class NotificationStatusRejected < NotificationStatus

  def send_mail(notification)
    NotificationMailer.notify_rejected(notification).deliver
    puts "Mail Type Confirmed"
  end

  def state
    'rejected'
  end

end