FactoryGirl.define do
  factory :multiple_choice_question, class: MultipleChoiceQuestion, parent: :question do
    answer_1 { %w(apple banana grape).sample }
    answer_2 { %w(walnut pecan cashew).sample }
    answer_3 { Forgery('name').company_name }
    answer_4 42
    correct_answer_number { (1 + rand(4)).to_s }
  end
end
