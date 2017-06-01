FactoryGirl.define do
  factory :question do
    body do
      query = %w(Who What Where When Why How).sample
      color = Forgery('basic').color
      animal = %w(cow pig chicken frog dog cat mouse).sample
      "#{ query } is #{ color } #{ animal }?"
    end
  end
end
