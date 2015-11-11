Rails.application.routes.draw do
  resource :session, only: [:create]

  root to: "high_voltage/pages#show", id: "homepage"
end
