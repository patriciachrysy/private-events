require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Athentication process', type: :system do
  describe 'Manage events' do
    before(:each) do
      visit sign_up_path
      fill_in 'Name', with: 'Capybara'
      fill_in 'Username', with: 'Capybara'
      fill_in 'Email', with: 'capybara@gmail.com'
      click_on 'OK'
      visit new_event_path
    end

    it 'Access the create event page' do
      expect(page).to have_content('Create an event')
    end

    it 'Create a new event, should redirect to event page if all is ok' do
      fill_in 'Name', with: 'Testing going on'
      fill_in 'Description', with: 'Capybara test case will be written and launched'
      fill_in 'Event date', with: DateTime.now
      fill_in 'Location', with: 'Internet'
      click_on 'Create Event'
      expect(page).to have_content('Testing going on')
    end

    it 'Show an event, should redirect to event page even if not sign in' do
      fill_in 'Name', with: 'Testing going on'
      fill_in 'Description', with: 'Capybara test case will be written and launched'
      fill_in 'Event date', with: DateTime.now
      fill_in 'Location', with: 'Internet'
      click_on 'Create Event'

      visit sign_out_path

      click_on 'Testing going on'

      expect(page).to have_content('Testing going on')
    end

    it 'Attend an event when invited by the author or an invited person' do
      visit sign_out_path
      visit sign_up_path
      sleep(5)
      fill_in 'Name', with: 'Microverse'
      fill_in 'Username', with: 'Microverse'
      fill_in 'Email', with: 'microverse@gmail.com'
      click_on 'OK'
      visit new_event_path

      fill_in 'Name', with: 'Launch and Learn'
      fill_in 'Description', with: 'How to become a remote developer'
      fill_in 'Event date', with: DateTime.now
      fill_in 'Location', with: 'Internet'
      click_on 'Create Event'

      click_on 'invite'
      visit sign_out_path
      visit sign_in_path
      fill_in 'Username', with: 'Capybara'
      click_on 'OK'
      sleep(5)
      click_on 'Accept invitation'
      click_on 'My profile'
      expect(page).to have_content('Launch and Learn')
    end
  end
end
