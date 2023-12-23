require 'rails_helper'

RSpec.describe 'UserShows', type: :system do
  before do
    driven_by(:rack_test)

    @user = FactoryBot.create(:user)
    create_list(:post, 3, author: @user) # Create 3 posts for the user
  end

  it 'displays user information correctly' do
    visit user_path(@user)

    expect(page).to have_css("img[src*='#{@user.photo}']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.posts_counter)
    expect(page).to have_content(@user.bio)
  end

  it 'displays the first 3 posts' do
    visit user_path(@user)

    @user.recent_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it 'redirects to the post show page when a post is clicked' do
    visit user_path(@user)
    first_post = @user.recent_posts.first
    click_on first_post.title, match: :first

    expect(page).to have_current_path(user_post_path(@user, first_post))
  end

  it 'redirects to the user posts index page when "See all posts" is clicked' do
    visit user_path(@user)
    click_on 'See all posts'

    expect(page).to have_current_path(user_posts_path(@user))
  end
end
