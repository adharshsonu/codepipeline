FactoryBot.define do
  factory :post, class: Post do
    sequence(:content) { |n| "Testing content - {n}" }
    user { |r| User.first || r.association(:user) }
  end
end