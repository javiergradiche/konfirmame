require 'rails_helper'

RSpec.describe Notification, :type => :model do
  describe "Model" do
    it "has a valid factory" do
    	notification = FactoryGirl.create(:notification)
    	expect(notification).to be_valid
    end
    it "is invalid without event_id" do
    	notification = FactoryGirl.build(:notification, event_id: nil)
    	expect(notification).to_not be_valid
    end
    it "is invalid without user_id" do
    	notification = FactoryGirl.build(:notification, user_id: nil)
    	expect(notification).to_not be_valid
    end
    it "is invalid without occurrence_id" do
    	notification = FactoryGirl.build(:notification, event_occurrence_id: nil)
    	expect(notification).to_not be_valid
    end
    it "is invalid without start_datetime" do
      notification = FactoryGirl.build(:notification, start_datetime: nil)
      expect(notification).to_not be_valid
    end
    it "is invalid without end_datetime" do
      notification = FactoryGirl.build(:notification, end_datetime: nil)
      expect(notification).to_not be_valid
    end
  end

  describe "Business" do

    let(:user) { FactoryGirl.create(:user)}
    let(:event){ FactoryGirl.create(:every_saturday_event) }
    let(:user2) { FactoryGirl.create(:user, :email => 'mail2@example.com')}
    let(:event2){ FactoryGirl.create(:every_saturday_event) }

    context "Prepare package to send" do
      it "not get notification before first_call" do
        event.add_user(user)
        expect(event).to be_valid
        now = Time.utc(2014, 4, 8, 16, 0)
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(0).items
      end

      it "not get notification after event_date" do
        event.add_user(user)
        expect(event).to be_valid
        now = Time.utc(2014, 4, 14, 16, 0)
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(0).items
      end

      it "not get notification if are confirmed or rejected" do
        event.add_user(user)
        expect(event).to be_valid
        now = Time.utc(2014, 4, 12, 10, 30)
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(1).items
        event.notifications.update_all(:state => 'confirmed')
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(0).items
        event.notifications.update_all(:state => 'rejected')
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(0).items
      end
      it "get notification if are pending, opened or sent" do
        event.add_user(user)
        expect(event).to be_valid
        now = Time.utc(2014, 4, 12, 10, 5)

        notifications = Notification.get_shippables(now) #pending
        expect(notifications).to have(1).items

        event.notifications.update_all(:state => 'sent')
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(1).items

        event.notifications.update_all(:state => 'opened')
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(1).items
      end
      it "not get notification if you are not at sending hour" do
        event.add_user(user)
        expect(event).to be_valid
        now = Time.utc(2014, 4, 11, 16, 0)
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(0).items
      end
      it "get notification if you are at sending hour" do
        event.add_user(user)
        expect(event).to be_valid
        now = Time.utc(2014, 4, 11, 10, 5)
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(1).items
      end
      it "get 2 notification for 2 events if you are at sending hour" do
        event.add_user(user)
        event2.add_user(user2)
        now = Time.utc(2014, 4, 11, 10, 5)
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(2).items
      end
      it "get 3 notification for 2 events (1user 2events) if you are at sending hour" do
        event.add_user(user)
        event.add_user(user2)
        event2.add_user(user2)
        now = Time.utc(2014, 4, 11, 10, 5)
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(3).items
      end
      it "get notification if are are not at sending hours but rush_hours" do
        event.add_user(user)
        expect(event).to be_valid
        now = Time.utc(2014, 4, 13, 13, 0)
        notifications = Notification.get_shippables(now)
        expect(notifications).to have(1).items
      end

    end

    context "Send" do

      it "notify all asking confirmation" do
        pending
        datetime = Time.now
        notification = Notification.new
        expect(NotificationMailer).to receive(:ask_confirmation)
        notification.time_to_notify(datetime)
      end

      it "update notification state"
      it "update occurrence attributes when confirmation"
      it "notify all when confirmation"
      it "notify all when aforo not completed before due date"
      it "notify all when aforo not completed after due date"

    end

  end
end
