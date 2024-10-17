Rails.application.routes.draw do
  root 'home#index'
  
  post 'activate_crawler', to: 'crawler#activate'

  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index]
    end
  end
end
