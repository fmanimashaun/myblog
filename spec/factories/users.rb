FactoryBot.define do
  factory :user do
    name { 'Tom' }
    photo { 'https://unsplash.com/photos/F_-0BxGuVvo' }
    bio { 'Teacher from Mexico.' }
    posts_counter { 0 }
  end
end
