require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { User.create!(name: "Test User") }

  describe "GET /index" do
    it "returns http success" do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it "renders the correct template" do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it "includes the correct placeholder text" do
      get user_posts_path(user)
      expect(response.body).to include("All Posts Page")
    end
  end

  describe "GET /show" do
    let(:post) { Post.create!(title: "Test Post", text: "Test Text", author: user) }

    it "returns http success" do
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end

    it "renders the correct template" do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it "includes the correct placeholder text" do
      get user_post_path(user, post)
      expect(response.body).to include("Single Post Page")
    end
  end
end
