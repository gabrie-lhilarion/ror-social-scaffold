require 'rails_helper'
# require 'rails_helper_capybara'
# Capybara.default_driver = :selenium_chrome

RSpec.feature 'Comment', type: :feature do
  context 'context' do
    before do
      @gabriel = User.create(email: 'gabriel@gmail.com', name: 'gabriel', password: '123456')
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'gabriel@gmail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
    end

    scenario 'Do a comment' do
      fill_in 'post_content', with: 'The day I went to the moon'
      click_on 'Save'
      find(:xpath, '//form[@id="new_comment"][@action="/posts/1/comments"]//input[@id="comment_content"]').set('i know')
      find(:xpath, '//form[@id="new_comment"][@action="/posts/1/comments"]').click_on('Comment')
      expect(page).to have_content('Comment was successfully created.')
    end
  end
end
