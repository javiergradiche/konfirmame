require 'rails_helper'

include IceCube

RSpec.describe Event, :type => :model do

  let(:event) { event = FactoryGirl.create(:event) }
  let(:start_time) { Time.now }
  let(:end_time)   { start_time + 3600 }

  describe "Models" do

    it "has a valid factory" do
    	expect(event).to be_valid
    end
    it "is invalid without name" do
      event = FactoryGirl.build(:event, name: nil)
      expect(event).to_not be_valid
    end
    it "is invalid without aforo" do
      event = FactoryGirl.build(:event, aforo: nil)
      expect(event).to_not be_valid
    end    
    it "is invalid without recurring_rule" do
    	event = FactoryGirl.build(:event, recurring_rule: nil)
    	expect(event).to_not be_valid
    end
    it "is invalid without start_date" do
      event = FactoryGirl.build(:event, start_date: nil)
      expect(event).to_not be_valid
    end
    it "is invalid without state" do
      event = FactoryGirl.build(:event, state: nil)
      expect(event).to_not be_valid
    end
    it "is invalid without first_call" do
      event = FactoryGirl.build(:event, first_call: nil)
      expect(event).to_not be_valid
    end
    it "is invalid without rush_start" do
      event = FactoryGirl.build(:event, rush_start: nil)
      expect(event).to_not be_valid
    end
    it "is invalid without call_hour" do
      event = FactoryGirl.build(:event, call_hour: nil)
      expect(event).to_not be_valid
    end
    it "has many user_events" do
      user_event = FactoryGirl.build(:user_event)
      user_event.event_id = event.id
      user_event.save
      expect(event).to have_at_least(1).user_events
    end
    it "has many occurences" do
      event_occurrence = FactoryGirl.build(:event_occurrence)
      event_occurrence.event_id = event.id
      event_occurrence.save
      expect(event).to have_at_least(1).event_occurrences
    end
    it "created has a 'active' state" do
      expect(event.state).to eq('active')
    end
  end

  describe "Business" do

    context "User" do
      it "add user to event" do
        event.add_user(user = FactoryGirl.create(:user))
        expect(user.has_event?(event)).to be true
      end
      it "remove user from event" do
        event.remove_user(user = FactoryGirl.create(:user))
        expect(user.has_event?(event)).to be false        
      end
    end

    context "Event Occurrences" do
      it "create with 1 occurrence Today" do
        start = Time.utc(2013, 5, 1)
        user = FactoryGirl.create(:user)
        event.add_user(user)
        expect(event).to have(1).event_occurrences
        expect(event.get_schedule_occurrences(1)[0]).to eq(start)
      end

      it "create with 2 occurrences today & tomorrow" do
        start = Time.utc(2013, 5, 1)
        event = FactoryGirl.create(:two_times_event)
        user = FactoryGirl.create(:user)
        event.add_user(user)
        expect(event).to have(2).event_occurrences
        expect(event.get_schedule_occurrences(2)[0]).to eq(start)
        expect(event.get_schedule_occurrences(2)[1]).to eq(start + 1.day)
      end
      
      it "create with 1 occurrences by 10 week" do
        start = Time.utc(2013, 5, 1)
        event = FactoryGirl.create(:ten_weeks_event)
        user = FactoryGirl.create(:user)
        event.add_user(user)
        expect(event).to have(10).event_occurrences
        expect(event.get_schedule_occurrences()[0]).to eq(start)
        expect(event.get_schedule_occurrences()[1]).to eq(start + 1.week)
        expect(event.get_schedule_occurrences()[9]).to eq(start + 9.week)
      end

      it "change occurrences date of week"
      it "change occurrences time"
      it "change occurrences increase 10 to 15"
      it "change occurrences increase 15 to 10 (5 past)"
      it "can't delete past occurrences"
      it "can't change past occurrences"
      it "can delete future occurrences"
    end

    context "Add Users" do
      let(:user) { user = FactoryGirl.create(:user) }
      let(:user) { user = FactoryGirl.create(:user_autoconfirm) }

      it "add_user with not autoconfirm and create 1 notification pending (0 confirmed)" do
        event.add_user(user)
        expect(event).to have(1).notifications
        expect(event.notifications.first.state).to eq('pending')
        expect(event.occurrences.first.conf_num).to eq(1)
      end
      it "add_user with autoconfirm and create 1 notification confirmed (1confirmed)" do
        event.add_user(user_autoconfirm)
        expect(event).to have(1).notifications
        expect(event.notifications.first.state).to eq('confirmed')
        expect(event.occurrences.first.conf_num).to eq(1)
      end

    end
  end
  context "Notifications" do
    let(:user) { user = FactoryGirl.create(:user) }
    before { event.add_user(user) }

    it "create with 1 notification (1 user)" do
      expect(event).to have(1).notifications
    end

    it "created has a 'pending' state" do
      expect(event.notifications.first.state).to eq('pending')
    end

    it "create with 4 notification (2 days, 2 users)" do
      event = FactoryGirl.create(:two_times_event)
      user2 = FactoryGirl.create(:user, :email => 'example2@example.com')
      event.add_user(user)
      event.add_user(user2)
      expect(event).to have(4).notifications
    end

    it "notify aforo completed"

  end

  describe "Mailers" do

    it "send mail when you added to event"
    it "send mail when you removed from event"
    context "send mail inform with occurrence state" do
      it "event not afored"
      it "event afored"
    end

  end

  describe "Stats" do
    it "top confirm users"
    it "top reject users"
  end
  
end
