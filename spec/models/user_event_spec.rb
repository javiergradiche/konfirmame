require 'rails_helper'

RSpec.describe UserEvent, :type => :model do
  it "has a valid factory" do
  	user_event = FactoryGirl.create(:user_event)
  	expect(user_event).to be_valid
  end
  it "is invalid without event_id" do
  	user_event = FactoryGirl.build(:user_event, event_id: nil)
  	expect(user_event).to_not be_valid
  end
  it "is invalid without user_id" do
  	user_event = FactoryGirl.build(:user_event, user_id: nil)
  	expect(user_event).to_not be_valid
  end
  it "is invalid without state" do
  	user_event = FactoryGirl.build(:user_event, state: nil)
  	expect(user_event).to_not be_valid
  end
end
