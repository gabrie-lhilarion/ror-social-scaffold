require 'rails_helper'

require 'rails_helper'

RSpec.describe 'Friendship', type: :feature, feature: true do
  before do
    @user = User.create(email: 'ma@m.com', name: 'Tt', password: '123456')
    @user2 = User.create(email: 'ma2@m.com', name: 'Tt2', password: '123456')
    visit 'http://localhost:3000/users/sign_in'
    fill_in 'Email', with: 'ma@m.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
  end

  scenario 'log_in valid' do
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'friend request' do
    visit 'http://localhost:3000/users'
    url = 'http://localhost:3000/request/'
    url.concat(@user2.id.to_s)
    visit url
    expect(@user.pending_requests).to include(@user2)
    expect(page).to have_content('Friend request sent')
  end

  scenario 'friend accept' do
    click_on 'Sign out'
    visit 'http://localhost:3000/users/sign_in'
    fill_in 'Email', with: 'ma2@m.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    # visit 'http://localhost:3000/users'
    url = 'http://localhost:3000/friendships/'
    url.concat(@user.id.to_s)
    page.driver.submit :get, url, {}
    expect(page).to have_content('You accept an Invitation')
  end

  scenario 'friend reject' do
    visit 'http://localhost:3000/users'
    url = 'http://localhost:3000/friendships/'
    url.concat(@user2.id.to_s)
    visit url
    click_on 'Sign out'
    visit 'http://localhost:3000/users/sign_in'
    fill_in 'Email', with: 'ma2@m.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    visit 'http://localhost:3000/users'
    url = 'http://localhost:3000/reject/'
    url.concat(@user.id.to_s)
    page.driver.submit :get, url, {}
    expect(page).to have_content('You reject an Invitation')
  end
end
