require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it "includes the correct placeholder text" do
      get users_path
      expect(response.body).to include("All Users Page")
    end
  end

  describe "GET /show" do
    let(:user) { create(:user) }

    it "returns http success" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it "includes the correct placeholder text" do
      get user_path(user)
      expect(response.body).to include("Single User Page")
    end
  end
end
