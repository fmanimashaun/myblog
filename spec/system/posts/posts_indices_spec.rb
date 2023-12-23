require 'rails_helper'

RSpec.describe 'UserPostsIndex', type: :system do
  before do
    driven_by(:rack_test)

    @user = FactoryBot.create(:user)
    create_list(:post, 10, author: @user) # Create 10 posts for pagination
  end

  it 'displays user information and posts correctly' do
    visit user_posts_path(@user)

    # User information
    expect(page).to have_css("img[src*='#{@user.photo}']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.posts_counter)

    # Post display
    @user.posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text.truncate(250)) # Check partial body
      expect(page).to have_content(post.comments_counter)
      expect(page).to have_content(post.likes_counter)

      # Check first comment if present
      expect(page).to have_content(post.recent_comments.first.text) unless post.recent_comments.empty?
    end

    # Pagination
    expect(page).to have_css('nav.pagination')
  end

  it 'redirects to the post show page when a post is clicked' do
    visit user_posts_path(@user)
    first_post = @user.posts.order(created_at: :desc).first
    click_on first_post.title, match: :first

    expect(page).to have_current_path(user_post_path(@user, first_post))
  end
end
