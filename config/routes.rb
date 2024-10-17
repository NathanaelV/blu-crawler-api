Rails.application.routes.draw do
  root 'home#index'
  
  post 'activate_crawler', to: 'crawler#activate'

  namespace :api do
    namespace :v1 do
      resources :categories, only: %i[index]
      resources :states, only: %i[index]
      resources :suppliers, only: %i[index show] do
        get 'search', on: :collection
      end
    end
  end
end
