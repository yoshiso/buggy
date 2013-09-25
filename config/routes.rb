Buggy::Application.routes.draw do
  root 'application#index'
  resources :projects
  resources :issues
end
