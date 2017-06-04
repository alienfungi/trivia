require 'rails_helper'

RSpec.feature 'User creates multiple choice questions' do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
    visit '/'
    click_link 'New Question'
  end

  scenario 'successfully' do
    fill_in 'Question', with: 'Why is the sky yellow?'
    fill_in 'Answer 1', with: 'Because 42'
    fill_in 'Answer 2', with: 'Because turtles all the way down'
    fill_in 'Answer 3', with: 'Because the ground is purple'
    fill_in 'Answer 4', with: 'Because I said so'
    select '1', from: 'Correct answer number'
    click_button 'Create Question'
    expect(page).to have_content('Successfully created question')
  end

  scenario 'with incomplete data' do
    click_button 'Create Question'
    expect(page).to have_content('Question can\'t be blank')
    expect(page).to have_content('Failed to create question')
  end
end
