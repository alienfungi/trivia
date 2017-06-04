require 'rails_helper'

RSpec.feature 'Views her own scores' do
  let!(:user) { create(:user) }

  before(:each) do
    sign_in user
    visit '/'
  end

  scenario 'that are long-term' do
    click_link 'View Scores'
    expect(page).to have_content user.longest_correct_streak
    expect(page).to have_content user.longest_incorrect_streak
    expect(page).to have_content user.score
    expect(page).to have_content user.total_correct_answers
    expect(page).to have_content user.total_incorrect_answers
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
end
