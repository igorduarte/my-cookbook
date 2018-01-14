FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "10203040"
    name 'Igor'
  end

  # factory :author, class: User do
  #   name 'Igor'
  #   sequence(:email) { |n| "person#{n}@example.com" }
  #   password "10203040"
  # end
end
