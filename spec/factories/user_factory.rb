FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      Forgery('internet').email_address.sub(/@/, "#{ n }@")
    end
    password 'password'
    password_confirmation 'password'
  end
end
