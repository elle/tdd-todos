Rails.application.routes.draw do
  resource :session, only: [:create]
  resources :todos, only: [:index, :new, :create]

  root to: "high_voltage/pages#show", id: "homepage"
end
