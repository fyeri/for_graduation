FactoryBot.define do
  factory :user do
    name { "user1" }
    email { "test@example.com" }
    password { "password1" }
  end

  factory :admin_user, class: User do
    name { "admin_user" }
    email { "admin@example.com" }
    password { "password1" }
    admin { true }
  end
end
