FactoryBot.define do
  factory :user, class: User do
    username { 'test-user' }
    email { 'test@gmail.com' }
    password { '123123' }
    password_confirmation { '123123' }
  end
end
