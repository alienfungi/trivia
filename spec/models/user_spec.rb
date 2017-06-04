require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:question) { build(:question) }
  let(:new_question) { build(:question) }

  describe '#assign_question' do
    before(:each) do
      allow(user).to receive(:save!) { true }
    end

    context 'without a previous question' do
      it 'should return true when given a new question' do
        expect(user.assign_question { new_question }).to be true
      end

      it 'should accept the new question' do
        user.assign_question { new_question }
        expect(user.question).to be new_question
      end
    end

    context 'with a previous question' do
      before(:each) do
        user.question = question
      end

      it 'should return false when given a new question' do
        expect(user.assign_question { new_question }).to be false
      end

      it 'should not accept a new question' do
        expect(user.question).not_to be new_question
        expect(user.question).to be question
      end
    end
  end
end
