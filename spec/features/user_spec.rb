require 'rails_helper'

RSpec.describe 'Testing Friendship features', type: :feature, feature: true do
  context 'context' do
    before do
      @gabriel = User.create(email: 'gabriel@gmail.com', name: 'gabriel', password: '123456')
      @ijeoma = User.create(email: 'ijeoma@gmail.com', name: 'ijeoma', password: '123456')
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'gabriel@gmail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
    end
    scenario 'Test if the user gabriel@gmail.com can log in' do
      expect(page).to have_content('Signed in successfully.')
    end
    scenario 'Create a friend request, Gabriel invites Ijeoma, check if a Pending request exist' do
      url = 'http://localhost:3000/users/'
      url.concat(@gabriel.id.to_s)
      page.driver.submit :post, url, {}
      expect(page).to have_content('Pending request')
      expect(@gabriel.pending_friends).to include @ijeoma
    end
    scenario 'Friend accept, Yaser invites Hans, Hans accepts the invitation' do
      # request
      url = 'http://localhost:3000/users/'
      url.concat(@gabriel.id.to_s)
      page.driver.submit :post, url, {}
      expect(@hans.pending_friends).to include @gabriel
      click_on 'Sign out'
      # Accept
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'gabriel@gmail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      visit 'http://localhost:3000/users'
      url = 'http://localhost:3000/users/'
      url.concat(@ijeoma.id.to_s)
      page.driver.submit :patch, url, {}
      expect(page).to have_content('You accept an Invitation')
    end
    scenario 'Friend reject, Gabriel invites, Ijeoma rejects the invitation' do
      # request
      url = 'http://localhost:3000/users/'
      url.concat(@gabriel.id.to_s)
      page.driver.submit :post, url, {}
      expect(@ijeoma.pending_friends).to include @gabriel
      # Reject
      click_on 'Sign out'
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'gabriel@gmail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      visit 'http://localhost:3000/users'
      url = 'http://localhost:3000/friendships/'
      url.concat(@ijeoma.id.to_s)
      page.driver.submit :delete, url, {}
      expect(page).to have_content('You reject an Invitation')
    end
  end
end