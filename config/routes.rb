Rails.application.routes.draw do

  get "proizvodi/select"
  get "firms/select"

  resources :proizvodi, only: [:index] do
    collection do
      post :select 
    end
  end
 
  resources :firms ,only: [:index] do
    collection do
      post :select
    end
  end
end
