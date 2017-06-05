require 'rails_helper'

RSpec.feature 'User views global scores' do
  let!(:user) { create(:user) }
  let!(:users) { create_list(:user, 16) }

  before(:each) do
    sign_in user
    visit '/'
    click_link 'View Scores'
  end

  scenario 'sees highest score on first page' do
    high_score = User.order(score: :desc).first.score
    within_table 'scoreboard' do
      expect(page).to have_content high_score
    end
  end

  scenario 'sees lowest score on second page', js: true do
    lowest_score = User.order(score: :asc).first.score
    within('#scoreboard_pagination') { click_link '2' }
    within_table 'scoreboard' do
      expect(page).to have_content lowest_score
    end
  end
end
