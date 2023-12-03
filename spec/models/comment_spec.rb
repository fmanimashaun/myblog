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

  describe 'counter_cache' do
    let(:post) { create(:post) }
    let(:comment) { create(:comment, post:) }

    context 'when a comment is created' do
      it 'increments comments_counter on post' do
        expect do
          comment
        end.to change { post.reload.comments_counter }.by(1)
      end
    end

    context 'when a comment is destroyed' do
      it 'decrements comments_counter on post' do
        comment
        expect do
          comment.destroy
        end.to change { post.reload.comments_counter }.by(-1)
      end
    end
  end
end
