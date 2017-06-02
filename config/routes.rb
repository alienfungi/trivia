Rails.application.routes.draw do
  root 'static_pages#index'

  resources :multiple_choice_questions, only: [:create, :new],
    controller: :questions, type: 'MultipleChoiceQuestion'
end
