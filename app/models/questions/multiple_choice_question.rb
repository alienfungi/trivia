# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  type       :string
#  body       :text             not null
#  options    :hstore           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class MultipleChoiceQuestion < Question
  OPTIONS_WHITELIST = [:answer_1, :answer_2, :answer_3, :answer_4, :correct_answer_number].freeze
  CORRECT_ANSWER_NUMBER_VALUES = %w(1 2 3 4).freeze

  store_accessor :options, OPTIONS_WHITELIST

  validates :answer_1, presence: true, length: { maximum: 255 }
  validates :answer_2, presence: true, length: { maximum: 255 }
  validates :answer_3, presence: true, length: { maximum: 255 }
  validates :answer_4, presence: true, length: { maximum: 255 }
  validates_inclusion_of :correct_answer_number, in: CORRECT_ANSWER_NUMBER_VALUES

  def self.options_whitelist
    OPTIONS_WHITELIST
  end

  def answer
    self.send("answer_#{ correct_answer_number }")
  end

  def check?(guessed_answer)
    guessed_answer.number.to_s == correct_answer_number.to_s
  end

  def correct_answer_number_values
    CORRECT_ANSWER_NUMBER_VALUES.dup
  end

  def answers_for_select
    correct_answer_number_values.map do |number|
      [self.send("answer_#{ number }"), number]
    end
  end
end
