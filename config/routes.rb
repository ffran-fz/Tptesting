Rails.application.routes.draw do
  root "hello#index"
  resources :tasks
end
