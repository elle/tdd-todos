Rails.application.routes.draw do
  resources :todos, only: [:index, :create]

  root to: "todos#index"
end
