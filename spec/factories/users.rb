FactoryBot.define do
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "10203040"
  end

  # factory :author, class: User do
  #   name 'Igor'
  #   sequence(:email) { |n| "person#{n}@example.com" }
  #   password "10203040"
  # end
end
