require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations' do
    it 'belongs to author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq :has_many
    end
  end

  context 'validations' do
    it 'validates presence and length of title' do
      post = build(:post, title: '')
      expect(post.valid?).to be_falsey
      expect(post.errors[:title]).to include("can't be blank")

      post.title = 'a' * 251
      expect(post.valid?).to be_falsey
      expect(post.errors[:title]).to include("is too long (maximum is 250 characters)")
    end

    it 'validates presence of text' do
      post = build(:post, text: '')
      expect(post.valid?).to be_falsey
      expect(post.errors[:text]).to include("can't be blank")
    end

    it 'validates numericality of comments_counter' do
      post = build(:post, comments_counter: 'abc')
      expect(post.valid?).to be_falsey
      expect(post.errors[:comments_counter]).to include('is not a number')

      post.comments_counter = -1
      expect(post.valid?).to be_falsey
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')

      post.comments_counter = 0
      expect(post.valid?).to be_truthy
    end

    it 'validates numericality of likes_counter' do
      post = build(:post, likes_counter: 'abc')
      expect(post.valid?).to be_falsey
      expect(post.errors[:likes_counter]).to include('is not a number')

      post.likes_counter = -1
      expect(post.valid?).to be_falsey
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')

      post.likes_counter = 0
      expect(post.valid?).to be_truthy
    end
  end

  describe '#recent_comments' do
    let(:post) { create(:post) }
    let!(:recent_comment) { create(:comment, post: post, created_at: 1.day.ago) }
    let!(:old_comment) { create(:comment, post: post, created_at: 1.week.ago) }
    let!(:older_comment) { create(:comment, post: post, created_at: 1.year.ago) }

    it 'returns the most recent comments' do
      expect(post.recent_comments.to_a).to eq([recent_comment, old_comment, older_comment])
    end
  end
end
