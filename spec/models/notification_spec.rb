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

    let(:dt_event) { dt_event = Time.utc(2013, 5, 1, 16, 0) }
    let(:rule) { rule = schedule_2_times.add_recurrence_rule IceCube::Rule.daily.count(2) }
    let(:event) { event = FactoryGirl.create(:event) }
    let(:user) { user = FactoryGirl.create(:user) }
    before {
      event.add_user(user)
    }

    context "Prepare package to send" do
      it "not get notification before first_call" do

      end
      it "not get notification after event_date"
      it "not get notification after last_call"
      it "get notification if are not accepted or rejected"
      it "get notification if are pending"
      it "get notification if are sended and pass more than 20 hours"
      it "get notification if are sended and you are at rush hour"
      it "get notification between first_call and last_call"
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
