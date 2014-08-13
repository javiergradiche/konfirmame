# encoding: utf-8
class NotificationMailer < ActionMailer::Base
  # include UrlHelpers
  require 'mandrill'
  # Rails.application.routes.url_helpers

  def mail_setup
    return Mandrill::API.new ENV['MANDRILL_API_KEY']
  end

  def ask_confirmation_mandrill(notification)
    user = notification.user
    occurrence = notification.event_occurrence
    event = notification.event

    m = mail_setup
    message = {
        :from_name=> "confirmame",
        :subject => 'Por favor confirmame que estas!',
        :to=>[
            {:email=> user.email, :name => user.full_name }
        ],
        :bcc_address => 'javier.gradiche@keants.com',
        :global_merge_vars=> [
            { :name=> "first_name", :content=> user.first_name },
            { :name=> "last_name", :content=> user.last_name },
            { :name=> "num_confirmed", :content=> occurrence.num_confirm },
            { :name=> "aforo", :content=> occurrence.aforo },
            { :name=> "event_name", :content=> event.name },
            { :name=> "occurrence_date", :content=> occurrence.start_datetime.to_date },
            { :name=> "occurrence_time", :content=> occurrence.start_datetime.to_time },
            { :name=> "url_open", :content=> notification_open_url(notification) },
            { :name=> "url_confirm", :content=> notification_confirm_url(notification) },
            { :name=> "url_reject", :content=> notification_reject_url(notification) }
        ],
        :from_email=>"please@konfirma.me"
    }
    begin
    	# sending = m.messages.send_template 'konf-ask-one', [{:name => 'main', :content => 'The main content block'}], message
    	sending = "m.messages.send_template 'konf-ask-one', [{:name => 'main', :content => 'The main content block'}], message"
    	puts sending
    rescue Mandrill::Error => e
		  puts "A mandrill error occurred: #{e.class} - #{e.message}"
		  raise
    end
  end

  def ask_confirmation(to, body)
    mail :subject => "Por favor confirmame que estas!",
         :to      => to,
         :from    => "vos@konfirma.me",
         :body 	  => body
  end

  def notify_confimation(to, body, confirm_user)
    mail :subject => "Por favor confirmame que estas!",
         :to      => "recipient@example.com",
         :from    => "vos@konfirma.me",
         :body 	  => body  	
  end

  def notify_not_completed_before(to, body)
    mail :subject => "Vamos que no llegamos a completar!",
     :to      => to,
     :from    => "vos@konfirma.me",
     :body 	  => body
  end

  def notify_not_completed_after(to, body)
    mail :subject => "No llegamos somos un desastre!",
         :to      => to,
         :from    => "vos@konfirma.me",
         :body 	  => body  	
  end

end