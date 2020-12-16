require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before do
    @gabriel = User.create(email: 'gabriel@mail.com', name: 'Gabriel', password: '123456')
    @ijeoma = User.create(email: 'ijeoma@mail.com', name: 'Ijeoma', password: '123456')
    @eustace = User.create(email: 'eustace@mail.com', name: 'eustace', password: '123456')
  end

  it 'Show relation of friends' do
    @gabriel.request_friend(ijeoma)
    @ijeoma.confirm_friend(@gabriel)
    u = User.find(@gabriel.id)
    expect(u.friend?(@ijeoma)).to be true
  end

  it 'Show there is no relation of friends' do
    u = User.find(@gabriel.id)
    expect(u.friend?(@eustace)).to be false
  end

  context 'Association' do
    it { expect(subject).to belong_to(:user) }
  end
end