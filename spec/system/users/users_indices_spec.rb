require 'rails_helper'

RSpec.describe 'UserIndices', type: :system do
  before do
    driven_by(:rack_test)

    # Create some users here using FactoryBot
    @user1 = FactoryBot.create(:user)
    @user2 =
      FactoryBot.create(
        :user,
        name: 'Jerry',
        photo: 'https://unsplash.com/photos/another_photo',
        bio: 'Engineer from Canada.',
        posts_counter: 5
      )
  end

  it 'displays the username of all other users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'displays the profile picture for each user' do
    visit users_path
    expect(page).to have_css("img[src*='#{@user1.photo}']")
    expect(page).to have_css("img[src*='#{@user2.photo}']")
  end

  it 'displays the number of posts each user has written' do
    visit users_path
    expect(page).to have_content(@user1.posts_counter)
    expect(page).to have_content(@user2.posts_counter)
  end

  it 'redirects to user show page when a user is clicked' do
    visit users_path
    click_on @user1.name
    expect(page).to have_current_path(user_path(@user1))
  end
end
