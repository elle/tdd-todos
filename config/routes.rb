Rails.application.routes.draw do
  resource :session, only: [:create]
  resources :todos, only: [:index, :new, :create] do
    resource :completion, only: [:create]
  end

  root to: "high_voltage/pages#show", id: "homepage"
end
