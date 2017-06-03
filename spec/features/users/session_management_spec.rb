require 'rails_helper'

RSpec.feature 'User manages session' do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit '/'
  end

  scenario 'successfully' do
    expect(page).not_to have_content('New Question')
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('New Question')
    click_link 'Log out'
    expect(page).not_to have_content('New Question')
  end

  scenario 'with incorrect password' do
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'not the password'
    click_button 'Log in'
    expect(page).not_to have_content('New Question')
    expect(page).to have_content('Invalid Email or password.')
  end
end
