class NotificationStatusPending < NotificationStatus

  def send_mail
    NotificationMailer.ask_confirmation_mandrill(self).deliver
    puts "Mail Type Pending"
  end

  def state
    'pending'
  end

end