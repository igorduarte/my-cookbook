require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'User' do
    it 'user is author' do
      user = create :user
      recipe = create :recipe, user: user

      expect(recipe.is_author?(user)).to be true
    end

    it 'user is not author' do
      user = create :user
      author = create :user, email: 'palmirinha@campus.com'
      recipe = create :recipe, user: author

      expect(recipe.is_author?(user)).to be false
    end
  end
end
