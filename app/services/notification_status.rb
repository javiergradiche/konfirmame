class NotificationStatus

  def send_mail(notification)
    raise NotImplementedError, 'You must implement the send_mail method'
  end

  def state
    raise NotImplementedError, 'You must implement the state method'
  end

end