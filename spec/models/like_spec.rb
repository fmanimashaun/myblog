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

  describe 'counter_cache' do
    let(:post) { create(:post) }
    let(:like) { create(:like, post:) }

    context 'when a like is created' do
      it 'increments likes_counter on post' do
        expect do
          like
        end.to change { post.reload.likes_counter }.by(1)
      end
    end

    context 'when a like is destroyed' do
      it 'decrements likes_counter on post' do
        like
        expect do
          like.destroy
        end.to change { post.reload.likes_counter }.by(-1)
      end
    end
  end
end
