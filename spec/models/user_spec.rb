# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  question_id            :integer
#

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

  describe '#answered_correctly!' do
    it 'should grant the user 4 points' do
      user.score = 0
      user.answered_correctly!
      expect(user.score).to be 4
    end
  end

  describe '#answered_incorrectly!' do
    it 'should deduct 1 point from the user' do
      user.score = 2
      user.answered_incorrectly!
      expect(user.score).to be 1
    end

    it 'should not be able to reduce score below 0' do
      user.score = 0
      user.answered_incorrectly!
      expect(user.score).to be 0
    end
  end
end
