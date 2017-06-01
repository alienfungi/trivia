class MultipleChoiceQuestion < Question
  store_accessor :options,
    :answer_1, :answer_2, :answer_3, :answer_4, :correct_answer_number

  validates_presence_of :answer_1, :answer_2, :answer_3, :answer_4
  validates_inclusion_of :correct_answer_number, in: (1..4)

  def check?(number_of_guess)
    number_of_guess.to_s == correct_answer_number.to_s
  end
end
