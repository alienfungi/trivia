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
#

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      Forgery('internet').email_address.sub(/@/, "#{ n }@")
    end
    password 'password'
    password_confirmation 'password'
    current_correct_streak { rand(5) > 1 ? rand(20) : 0 }
    current_incorrect_streak { current_correct_streak == 0 ? 1 + rand(20) : 0 }
    longest_correct_streak { current_correct_streak + rand(20) }
    longest_incorrect_streak { current_incorrect_streak + rand(15) }
    total_correct_answers { longest_correct_streak + current_correct_streak + rand(50) }
    total_incorrect_answers { longest_incorrect_streak + current_incorrect_streak + rand(40) }
    score { (total_correct_answers * 2) + rand(42) }
  end
end
