require 'rails_helper'

RSpec.feature 'Views her own scores' do
  let!(:user) do
    create :user,
      longest_correct_streak: 15,
      longest_incorrect_streak: 22,
      score: 144,
      total_correct_answers: 50,
      total_incorrect_answers: 17
  end

  before(:each) do
    sign_in user
    visit '/'
  end

  scenario 'that are long-term' do
    click_link 'View Scores'
    within('#longest_correct_streak')   { expect(page).to have_content 15 }
    within('#longest_incorrect_streak') { expect(page).to have_content 22 }
    within('#score')                    { expect(page).to have_content 144 }
    within('#total_correct_answers')    { expect(page).to have_content 50 }
    within('#total_incorrect_answers')  { expect(page).to have_content 17 }
  end

  scenario 'when she is on a correct streak' do
    user.answered_correctly!
    click_link 'View Scores'
    expect(page).to have_content "#{ user.current_correct_streak } correct"
  end

  scenario 'when she is on an incorrect streak' do
    user.answered_incorrectly!
    click_link 'View Scores'
    expect(page).to have_content "#{ user.current_incorrect_streak } incorrect"
  end

  scenario 'when she has created questions' do
    create_list(:multiple_choice_question, 3, user: user)
    click_link 'View Scores'
    within('#questions_created') { expect(page).to have_content 3 }
  end
end
