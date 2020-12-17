require 'rails_helper'

RSpec.describe User, type: :model do

  context 'ActiveRecord associations' do
    it 'has many post' do
      expect(User.reflect_on_association(:posts).macro).to be(:has_many)
    end
  end

  context 'ActiveRecord associations' do
    it 'has many comments' do
      expect(User.reflect_on_association(:comments).macro).to be(:has_many)
    end
  end

  context 'ActiveRecord associations' do
    it 'has many likes' do
      expect(User.reflect_on_association(:likes).macro).to be(:has_many)
    end
  end

  context 'ActiveRecord associations' do
    it 'has many friendships' do
      expect(User.reflect_on_association(:friendships).macro).to be(:has_many)
    end
  end

  context 'ActiveRecord associations' do
    it 'has many inverse_friendships' do
      expect(User.reflect_on_association(:inverse_friendships).macro).to be(:has_many)
    end
  end

  context 'ActiveRecord associations' do
    it 'has many pending_friendships' do
      expect(User.reflect_on_association(:pending_friendships).macro).to be(:has_many)
    end
  end

end