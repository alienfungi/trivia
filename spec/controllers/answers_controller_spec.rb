require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { build(:multiple_choice_question) }
  let(:answer) { MultipleChoiceQuestionAnswer.new }

  describe '#create' do
    before(:each) do
      sign_in user
      user.question = question
      allow(controller).to receive(:current_user) { user }
      allow(question).to receive(:blank_answer) { answer }
    end

    it 'should call User#answered_correctly! for a correct answer' do
      expect(question).to receive(:check?).with(answer) { true }
      expect(user).to receive(:answered_correctly!) { true }
      post :create, params: {
        multiple_choice_question_answer: {
          number: '1'
        }
      }
    end

    it 'should call User#answered_incorrectly! for a wrong answer' do
      expect(question).to receive(:check?).with(answer) { false }
      expect(user).to receive(:answered_incorrectly!) { true }
      post :create, params: {
        multiple_choice_question_answer: {
          number: '1'
        }
      }
    end
  end
end
