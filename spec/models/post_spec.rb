require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations' do
    it 'belongs to author, has many comments and has many likes' do
      associations = { author: :belongs_to, comments: :has_many, likes: :has_many }
      associations.each do |association, macro|
        expect(described_class.reflect_on_association(association).macro).to eq macro
      end
    end
  end

  context 'validations' do
    it 'validates presence and length of title' do
      post = build(:post, title: '')
      expect(post.valid?).to be_falsey
      expect(post.errors[:title]).to include("can't be blank")
      post.title = 'a' * 251
      expect(post.valid?).to be_falsey
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
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
    let!(:recent_comment) { create(:comment, post:, created_at: 1.day.ago) }
    let!(:old_comment) { create(:comment, post:, created_at: 1.week.ago) }
    let!(:older_comment) { create(:comment, post:, created_at: 1.year.ago) }

    it 'returns the most recent comments' do
      expect(post.recent_comments.to_a).to eq([recent_comment, old_comment, older_comment])
    end
  end
end
