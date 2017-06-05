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

FactoryGirl.define do
  factory :question do
    body do
      query = %w(Who What Where When Why How).sample
      color = Forgery('basic').color
      animal = %w(cow pig chicken frog dog cat mouse).sample
      "#{ query } is #{ color } #{ animal }?"
    end
    category_list do
      quantity = rand 4
      results = []
      quantity.times { results << Forgery('name').job_title }
      results.join(', ')
    end
  end
end
