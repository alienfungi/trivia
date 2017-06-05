# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :inet
#  last_sign_in_ip          :inet
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  question_id              :integer
#  score                    :integer          default(0), not null
#  longest_correct_streak   :integer          default(0), not null
#  longest_incorrect_streak :integer          default(0), not null
#  current_correct_streak   :integer          default(0), not null
#  current_incorrect_streak :integer          default(0), not null
#  total_correct_answers    :integer          default(0), not null
#  total_incorrect_answers  :integer          default(0), not null
#  username                 :string           default(""), not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :question, optional: true

  validates :username, uniqueness: true,
    format: { with: /\A[a-z]\w+\z/i }, length: { within: (3..12) }

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
      augment_score_by correct_answer_value
      increment_current_correct_streak
      increment_total_correct_answers
      save!
    end
  end

  def answered_incorrectly!
    with_lock do
      augment_score_by incorrect_answer_value
      increment_current_incorrect_streak
      increment_total_incorrect_answers
      save!
    end
  end

  def current_streak
    current_correct_streak + current_incorrect_streak
  end

  def current_streak_type
    if current_correct_streak >= current_incorrect_streak
      :correct
    else
      :incorrect
    end
  end

  def total_answers
    total_correct_answers + total_incorrect_answers
  end

  private

  def augment_score_by(amount)
    new_score = score + amount
    self.score = new_score >= 0 ? new_score : 0
  end

  def correct_answer_value
    4
  end

  def incorrect_answer_value
    -1
  end

  def increment_current_correct_streak
    self.current_correct_streak += 1
    self.current_incorrect_streak = 0
    if current_correct_streak > longest_correct_streak
      self.longest_correct_streak = current_correct_streak
    end
  end

  def increment_current_incorrect_streak
    self.current_incorrect_streak += 1
    self.current_correct_streak = 0
    if current_incorrect_streak > longest_incorrect_streak
      self.longest_incorrect_streak = current_incorrect_streak
    end
  end

  def increment_total_correct_answers
    self.total_correct_answers += 1
  end

  def increment_total_incorrect_answers
    self.total_incorrect_answers += 1
  end
end
