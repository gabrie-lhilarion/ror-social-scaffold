require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'ActiveRecord associations' do
    it 'belongs to User' do
      expect(Friendship.reflect_on_association(:user).macro).to be(:belongs_to)
    end
  end

  context 'ActiveRecord associations' do
    it 'belongs to Event' do
      expect(Friendship.reflect_on_association(:friend).macro).to be(:belongs_to)
    end
  end
end