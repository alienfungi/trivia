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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :question, optional: true

  def assign_question(&proposed_question)
    if question
      false
    else
      self.question = proposed_question.call
      save!
    end
  end

  def answered_correctly!
    with_lock do
      self.score += 4
      save!
    end
  end

  def answered_incorrectly!
    with_lock do
      self.score = score >= 1 ? score - 1 : 0
      save!
    end
  end
end
