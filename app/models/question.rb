class Question < ApplicationRecord
  validates_presence_of :body

  def check?(guessed_answer)
    raise NotImplementedError
  end
end
