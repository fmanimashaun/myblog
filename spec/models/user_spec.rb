require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it 'has many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
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
    it 'validates presence of name' do
      user = build(:user, name: nil)
      expect(user.valid?).to be_falsey
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates numericality of posts_counter' do
      user = build(:user, name: 'Test User', posts_counter: 'abc')
      expect(user.valid?).to be_falsey
      expect(user.errors[:posts_counter]).to include('is not a number')

      user.posts_counter = -1
      expect(user.valid?).to be_falsey
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')

      user.posts_counter = 0
      expect(user.valid?).to be_truthy
    end
  end

  context '#recent_posts' do
    let(:user) { create(:user) }
    let!(:recent_post) { create(:post, author: user, created_at: 1.day.ago) }
    let!(:old_post) { create(:post, author: user, created_at: 1.week.ago) }
    let!(:older_post) { create(:post, author: user, created_at: 1.year.ago) }

    it 'returns the most recent posts' do
      expect(user.recent_posts.to_a).to eq([recent_post, old_post, older_post])
    end
  end

  context '#posts_counter' do
    let(:user) { create(:user) }

    it 'updates posts_counter when a post is created' do
      expect do
        create(:post, author: user)
      end.to change { user.reload.posts_counter }.by(1)
    end

    it 'updates posts_counter when a post is destroyed' do
      post = create(:post, author: user)
      expect do
        post.destroy
      end.to change { user.reload.posts_counter }.by(-1)
    end
  end
end
