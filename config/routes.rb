Rails.application.routes.draw do
  resources :subjects
  resources :test_groups
  devise_for :users
  resources :live_tests, only: [:index, :show]
  resources :solutions
  resources :answers
  resources :questions
  resources :tests
  get "tests/perform_test/:id/", to: "tests#perform_test"
  root "tests#index"
end
