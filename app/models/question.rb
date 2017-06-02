class Question < ApplicationRecord
  QUESTION_TYPES = %w(MultipleChoiceQuestion).freeze

  validates_presence_of :body
  validates_length_of :body, maximum: 255

  before_validation :cleanse_options

  def self.question_types
    QUESTION_TYPES.dup
  end

  def self.options_whitelist
    raise NotImplementedError
  end

  def check?(guessed_answer)
    raise NotImplementedError
  end

  private

  def cleanse_options
    options.keep_if do |option|
      self.class.options_whitelist.include? option.to_sym
    end
  end
end
