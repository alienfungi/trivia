require 'rails_helper'

RSpec.describe MultipleChoiceQuestion do
  let(:question) do
    build :multiple_choice_question, answer_1: 'tuba', correct_answer_number: '1'
  end
  let(:wrong_answer) { MultipleChoiceQuestionAnswer.new(number: '2') }
  let(:right_answer) { MultipleChoiceQuestionAnswer.new(number: '1') }

  it { should validate_presence_of(:answer_1) }
  it { should validate_presence_of(:answer_2) }
  it { should validate_presence_of(:answer_3) }
  it { should validate_presence_of(:answer_4) }
  it { should validate_inclusion_of(:correct_answer_number).in_array(%w(1 2 3 4)) }

  it 'checks if an answer is correct' do
    expect(question.check?(wrong_answer)).to be_falsey
    expect(question.check?(right_answer)).to be_truthy
  end
end
