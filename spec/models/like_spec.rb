
require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'ActiveRecord associations' do
    it 'belongs to User' do
      expect(Like.reflect_on_association(:user).macro).to be(:belongs_to)
    end
  end

  context 'ActiveRecord associations' do
    it 'belongs to friend' do
      expect(Like.reflect_on_association(:post).macro).to be(:belongs_to)
    end
  end
end