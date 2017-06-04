Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  resources :multiple_choice_questions, only: [:create, :new],
    controller: :questions, type: 'MultipleChoiceQuestion'

  resources :answers, only: [:create, :new]

  resources :users, only: [:show]
end
