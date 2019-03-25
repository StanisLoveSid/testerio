Rails.application.routes.draw do
  resources :live_tests, only: [:index, :show]
  resources :solutions
  resources :answers
  resources :questions
  resources :tests
  get "tests/perform_test/:id/", to: "tests#perform_test"
  root "tests#index"
end
