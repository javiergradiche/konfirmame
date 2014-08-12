# encoding: utf-8
class NotificationMailer < ActionMailer::Base

  require 'mandrill'

  def mail_setup
    return Mandrill::API.new ENV['MANDRILL_API_KEY']
  end

  def ask_confirmation_mandrill(to, body)
    m = mail_setup
    message = {
        :from_name=> "confirmame",
        :subject => 'Por favor confirmame que estas!',
        :to=>[
            {:email=> 'javiergradiche@gmail.com', :name=> "Mi GMAIL" }
        ],
        :bcc_address => 'javier.gradiche@keants.com',
        :global_merge_vars=> [
            { :name=> "first_name", :content=> "to.first_name" },
            { :name=> "last_name", :content=> "to.last_name" },
            { :name=> "num_confirmed", :content=> "num_confirmed" },
            { :name=> "aforo", :content=> "aforo" },
            { :name=> "event_name", :content=> "event_name" },
            { :name=> "occurrence_date", :content=> "occurrence_date" },
            { :name=> "occurrence_time", :content=> "occurrence_time" },
            { :name=> "url_open", :content=> "to.url_open" },
            { :name=> "url_confirm", :content=> "to.url_confirm" },
            { :name=> "url_reject", :content=> "to.url_reject" },
            { :name=> "url_pospose", :content=> "to.url_pospose" },
        ],
        :from_email=>"please@konfirma.me"
    }
    begin
    	sending = m.messages.send_template 'konf-ask-one', [{:name => 'main', :content => 'The main content block'}], message
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