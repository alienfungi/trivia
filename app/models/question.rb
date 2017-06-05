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
#

class Question < ApplicationRecord
  QUESTION_TYPES = %w(MultipleChoiceQuestion).freeze

  acts_as_taggable_on :categories

  has_many :users

  validates_presence_of :body
  validates_length_of :body, maximum: 255

  before_validation :cleanse_categories
  before_validation :cleanse_options

  class << self
    def question_types
      QUESTION_TYPES.dup
    end

    def options_whitelist
      raise NotImplementedError
    end

    def retrieve
      order('RANDOM()').first
    end
  end

  def answer
    raise NotImplementedError
  end

  def blank_answer
    "#{ self.class.name }Answer".constantize.new
  end

  def check?(guessed_answer)
    raise NotImplementedError
  end

  private

  def cleanse_categories
    category_list.map! do |category|
      category.gsub(/\s+/, ' ')
    end
  end

  def cleanse_options
    options.keep_if do |option|
      self.class.options_whitelist.include? option.to_sym
    end
  end
end
