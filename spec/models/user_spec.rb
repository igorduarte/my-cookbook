require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'User' do
    it 'is author' do
      user = create :user
      recipe = create :recipe, user: user

      expect(user.author?(recipe)).to be true
    end

    it 'is not author' do
      user = create :user
      author = create :user, email: 'palmirinha@campus.com'
      recipe = create :recipe, user: author

      expect(user.author?(recipe)).to be false
    end

    it "favorite recipe" do
      user = create(:user, email: 'ana.maria.braga@gmail.com')
      recipe = create(:recipe, user: user )
      create(:favorite, recipe: recipe, user: user)

      expect(user.favorited?(recipe)). to be true
    end

    it "not favorite recipe" do
      user = create(:user, email: 'ana.maria.braga@gmail.com')
      recipe = create(:recipe, user: user )

      expect(user.favorited?(recipe)). to be false
    end

    it "favorite recipe is nil" do
      user = create :user

      expect(user.favorited?(nil)).to be false
    end
  end
end
