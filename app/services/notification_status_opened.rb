class NotificationStatusOpened < NotificationStatus

  def send_mail(notification)
    puts "Notification Opened"
  end

  def state
    'opened'
  end

end