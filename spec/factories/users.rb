FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    name 'Igor'
    password "10203040"
  end
end
