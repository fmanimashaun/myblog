require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }

  describe "GET /index" do
    it "returns http success" do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it "includes the correct placeholder text" do
      get user_posts_path(user)
      expect(response.body).to include("All Posts Page")
    end
  end

  describe "GET /show" do
    let(:post) { create(:post, author: user) }

    it "returns http success" do
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end

    it "includes the correct placeholder text" do
      get user_post_path(user, post)
      expect(response.body).to include("Single Post Page")
    end
  end
end
