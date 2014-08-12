require 'rails_helper'

RSpec.describe "UserEvents", :type => :request do
  describe "GET /user_events" do
    it "works!" do
      get user_events_path
      expect(response.status).to be(200)
    end
  end
end
