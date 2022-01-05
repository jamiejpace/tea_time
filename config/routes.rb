Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: :create do
        resources :subscriptions, only: [:index, :create, :update]
      end
    end
  end
end
