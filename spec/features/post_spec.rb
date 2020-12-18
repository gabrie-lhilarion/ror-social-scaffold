require 'rails_helper'

RSpec.feature 'Post', type: :feature do
  context 'context' do
    before do
      @hans = User.create(email: 'gabriel@gmail.com', name: 'gabriel', password: '123456')
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'gabriel@gmail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
    end

    scenario 'Do a post' do
      fill_in 'post_content', with: 'Hey! is this Chrismass'
      click_on 'Save'
      expect(page).to have_content('Post was successfully created.')
    end
  end
end
