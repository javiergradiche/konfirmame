require 'rails_helper'

RSpec.describe "EventOccurrences", :type => :request do
  describe "GET /event_occurrences" do
    it "works! (now write some real specs)" do
      get event_occurrences_path
      expect(response.status).to be(200)
    end
  end
end
