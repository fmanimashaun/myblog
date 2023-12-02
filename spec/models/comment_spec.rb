require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { build(:comment, user:, post:) }

  describe 'associations' do
    it 'belongs to user' do
      expect(comment.user).to eq(user)
    end

    it 'belongs to post' do
      expect(comment.post).to eq(post)
    end
  end

  describe 'validations' do
    it 'validates presence of text' do
      comment.text = nil
      expect(comment).not_to be_valid
      expect(comment.errors[:text]).to include("can't be blank")
    end
  end
end
