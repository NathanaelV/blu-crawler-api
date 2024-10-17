Rails.application.routes.draw do
  root 'home#index'
  
  post 'activate_crawler', to: 'crawler#activate'
end
