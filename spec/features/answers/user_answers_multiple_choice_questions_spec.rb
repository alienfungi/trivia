require 'rails_helper'

RSpec.feature 'User answers multiple choice questions' do
  let!(:user) { create(:user) }

  before(:each) do
    sign_in user
    visit '/'
  end

  scenario 'when no questions exist' do
    click_link 'Answer Question'
    expect(page).to have_content 'No questions available'
  end

  context 'when one exists' do
    let!(:question) { create(:multiple_choice_question) }

    scenario 'successfully' do
      click_link 'Answer Question'
      expect(page).not_to have_content 'No questions available'
      choose(question.answer)
      click_button 'Answer'
      expect(page).to have_content 'Correct!'
    end
  end

end
