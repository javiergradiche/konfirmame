require 'rails_helper'

RSpec.describe "Notifications", :type => :request do
  describe "GET /notifications" do
    it "works! (now write some real specs)" do
      get notifications_path
      expect(response.status).to be(200)
    end
  end
  describe "MAIL Actions" do
    # get '/notification/:id/open' => 'notifications#open', as: :notification_open
    # get '/notification/:id/confirm' => 'notifications#confirm', as: :notification_confirm
    # get '/notification/:id/reject' => 'notifications#reject', as: :notification_reject
    # get '/notification/:id/pospose' => 'notifications#pospose', as: :notification_pospose

    let(:user) { FactoryGirl.create(:user)}
    let(:event){ FactoryGirl.create(:every_saturday_event) }

    it "update the requested notification with state OPENED" do
      event.add_user(user)
      now = Time.utc(2014, 4, 12, 10, 5)
      notifications = Notification.get_shippables(now) #pending

      get notification_open_path(notifications.first.id)
      expect(response.status).to be(200)

      expect(response).to render_template("event_occurrences/stats", "layouts/application")

      notification = event.notifications.first
      expect(notification.state).to eq('opened')
    end

    it "update the requested notification with state CONFIRMED" do
      event.add_user(user)
      now = Time.utc(2014, 4, 12, 10, 5)
      notifications = Notification.get_shippables(now) #pending

      get notification_confirm_path(notifications.first.id)
      expect(response.status).to be(200)

      expect(response).to render_template("event_occurrences/stats", "layouts/application")

      notification = event.notifications.first
      expect(notification.state).to eq('confirmed')

      occurrence = event.event_occurrences.first
      expect(occurrence.num_confirm).to eq(1)
    end

    it "update the requested notification with state REJECTED" do
      event.add_user(user)
      now = Time.utc(2014, 4, 12, 10, 5)
      notifications = Notification.get_shippables(now) #pending

      get notification_reject_path(notifications.first.id)
      expect(response.status).to be(200)

      expect(response).to render_template("event_occurrences/stats", "layouts/application")

      notification = event.notifications.first
      expect(notification.state).to eq('rejected')
    end
    it "update the requested notification with state DENIED" do
      event.add_user(user)
      now = Time.utc(2014, 4, 12, 10, 5)
      notifications = Notification.get_shippables(now) #pending
      occurrence = event.event_occurrences.first
      occurrence.num_confirm = occurrence.aforo
      occurrence.save

      get notification_confirm_path(notifications.first.id)
      expect(response.status).to be(200)

      expect(response).to render_template("event_occurrences/stats", "layouts/application")

      notification = event.notifications.first
      expect(notification.state).to eq('denied')
    end

  end
end
