class NotificationStatusDenied < NotificationStatus

  def send_mail(notification)
    NotificationMailer.notify_denied(notification).deliver
    puts "Mail Type Denied"
  end

  def state
    'denied'
  end

end