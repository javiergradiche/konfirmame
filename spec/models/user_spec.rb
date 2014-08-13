require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { user = FactoryGirl.create(:user) }

  describe "Models" do

    it "has a valid factory" do
    	expect(user).to be_valid
    end
    it "is invalid without email" do
    	user = FactoryGirl.build(:user, email: nil)
    	expect(user).to_not be_valid
    end
    it "is invalid without password" do
    	user = FactoryGirl.build(:user, password: nil)
    	expect(user).to_not be_valid
    end
    it "is invalid without password lengh < 8" do
    	user = FactoryGirl.build(:user, password: '1234567', password_confirmation: '1234567')
    	expect(user).to_not be_valid
    end
    it "is invalid without first name" do
      user = FactoryGirl.build(:user, first_name: nil)
      expect(user).to_not be_valid
    end
    it "is invalid without last name" do
      user = FactoryGirl.build(:user, last_name: nil)
      expect(user).to_not be_valid
    end
  end

  describe "Business" do

    it "add user to event " do
      event = FactoryGirl.create(:event)
      event.add_user(user) 
      expect(user.has_event? event).to be true 
    end
    it "add many users to event" do
      event1 = FactoryGirl.create(:event)
      event2 = FactoryGirl.create(:event)
      event3 = FactoryGirl.create(:event)
      event1.add_user(user) 
      event2.add_user(user) 
      event3.add_user(user)
      expect(user.has_event? event1).to be true 
      expect(user.has_event? event2).to be true 
      expect(user.has_event? event3).to be true 
    end

  end

  describe "Mailers" do
    it "send mail when receive invitation"
    it "send mail when accept invitation"
  end
end
