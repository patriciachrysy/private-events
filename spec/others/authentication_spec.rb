require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Athentication process', type: :system do
  describe 'access signup page' do
    it 'shows the right content' do
      visit sign_up_path
      expect(page).to have_content('Sign Up')
    end
  end

  describe 'signup a new user' do
    before(:each) do
      visit sign_up_path
    end

    it 'Redirect to homepage' do
      fill_in 'Name', with: 'Capybara'
      fill_in 'Username', with: 'Capybara'
      fill_in 'Email', with: 'capybara@gmail.com'
      click_on 'OK'
      expect(page).to have_content('WELCOME CAPYBARA')
    end

    it 'Does not redirect to homepage if the username is already taken' do
      fill_in 'Name', with: 'Capybara'
      fill_in 'Username', with: 'Capybara'
      fill_in 'Email', with: 'capybara@gmail.com'
      click_on 'OK'

      visit sign_out_path

      visit sign_up_path

      fill_in 'Name', with: 'Capybara'
      fill_in 'Username', with: 'Capybara'
      fill_in 'Email', with: 'capybara@gmail.com'
      click_on 'OK'
      expect(page).to have_content('This username is already taken, choose another one')
    end
  end

  describe 'Sign a user in' do
    it 'Redirect to homepage' do
      visit sign_up_path
      fill_in 'Name', with: 'Capybara'
      fill_in 'Username', with: 'Capybara'
      fill_in 'Email', with: 'capybara@gmail.com'
      click_on 'OK'

      visit sign_out_path

      visit sign_in_path
      fill_in 'Username', with: 'Capybara'
      click_on 'OK'
      expect(page).to have_content('WELCOME CAPYBARA')
    end

    it 'Does not redirect to homepage when the username does not exist' do
      visit sign_up_path
      fill_in 'Name', with: 'Capybara'
      fill_in 'Username', with: 'Capybara'
      fill_in 'Email', with: 'capybara@gmail.com'
      click_on 'OK'

      visit sign_out_path

      visit sign_in_path
      fill_in 'Username', with: 'capybara'
      click_on 'OK'
      expect(page).to have_content('Incorrect username, please try again')
    end
  end
end
