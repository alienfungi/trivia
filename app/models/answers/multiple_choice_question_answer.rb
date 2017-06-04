class MultipleChoiceQuestionAnswer < Answer
  attr_accessor :number

  validates_presence_of :number
end
