require 'rails_helper'

RSpec.describe EventOccurrence, :type => :model do

  let(:event_occurrence) { FactoryGirl.create(:event_occurrence) }
  describe "Model" do
    it "has a valid factory" do
      expect(event_occurrence).to be_valid
    end
    it "is invalid without event_id" do
      event_occurrence = FactoryGirl.build(:event_occurrence, event_id: nil)
      expect(event_occurrence).to_not be_valid
    end
  end

  describe "Business" do
  end
end
