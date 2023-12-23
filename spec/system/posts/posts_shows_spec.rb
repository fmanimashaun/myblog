require 'rails_helper'
RSpec.describe 'PostShow', type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, author: @user)
    create_list(:comment, 3, post: @post) # Create comments for the post
  end
  it 'displays post information and comments correctly' do
    visit user_post_path(@user, @post)
    # Post header
    expect(page).to have_content(@post.title)
    expect(page).to have_content("by #{@user.name}")
    expect(page).to have_content("Comments: #{@post.comments.count}")
    expect(page).to have_content("Likes: #{@post.likes.count}")
    # Post body
    expect(page).to have_content(@post.text)
    # Comments
    expect(page).to have_css('h5', text: 'All the Comments:')
    @post.comments.each do |comment|
      expect(page).to have_content("#{comment.user.name}: #{comment.text}")
    end
  end
  it 'redirects to the new comment form when "Add comment" is clicked' do
    visit user_post_path(@user, @post)
    click_on 'Add comment'
    expect(page).to have_current_path(new_user_post_comment_path(@user, @post))
  end
end