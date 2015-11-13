Rails.application.routes.draw do
  resources :sessions, only: [:new, :create]
  resources :todos, only: [:index, :create]

  root to: "todos#index"
end
