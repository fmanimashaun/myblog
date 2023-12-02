require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like) { build(:like, user:, post:) }

  describe 'associations' do
    it 'belongs to user' do
      expect(like.user).to eq(user)
    end

    it 'belongs to post' do
      expect(like.post).to eq(post)
    end
  end
end
