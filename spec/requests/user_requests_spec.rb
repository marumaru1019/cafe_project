require 'rails_helper'

RSpec.describe "UserRequests", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/user_requests/create"
      expect(response).to have_http_status(:success)
    end
  end

end
