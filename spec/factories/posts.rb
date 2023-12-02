FactoryBot.define do
  factory :post do
    association :author, factory: :user
    title { 'Hello' }
    text { 'This is my first post' }
    comments_counter { 0 }
    likes_counter { 0 }
  end
end
