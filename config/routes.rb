Buggy::Application.routes.draw do
  root 'application#index'
  resources :projects
  resources :issues
  resources :sessions, only: [:create, :destroy]
end
