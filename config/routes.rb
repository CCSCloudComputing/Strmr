Strmr::Application.routes.draw do
  
  resources :groups
  resources :users
  resources :sessions, only: [:new, :create, :destroy]


  # Group init
  match "join"  => "groups#join", as: "join_group" # View
  match "add"   => "groups#add", as: "add_group"   # Processing
  match "leave" => "groups#leave", as: "leave_group"

  # User processing
  match "signup" => "users#new", as: "signup"

  # Session management
  match "login"  => "sessions#new", as: "login"
  match "logout" => "sessions#destroy", as: "logout"

  root :to => "sessions#new"

  # ROUTE ALL PAGE NOT FOUND TO 404
  #match "*a" => "static#not_found" # TODO

end
