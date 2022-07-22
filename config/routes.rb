Rails.application.routes.draw do
  root 'home#index'
  resources :friends

  get "sign_in", to: "session#new"
  post "sign_in", to: "session#create"

  get "sign_up", to: "registration#new"
  post "sign_up", to: "registration#create"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create" 
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update" 

  delete "logout", to: "session#destroy"

  get "workspace/list", to: "workspaces#new"

  # get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
