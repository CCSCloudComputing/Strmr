Strmr::Application.routes.draw do
  
  #resources :groups # TODO
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  # User processing
  match "signup" => "users#new", as: "signup"

  # Session management
  match "login"  => "sessions#new", as: "login"
  match "logout" => "sessions#destroy", as: "logout"

  root :to => "sessions#new"

  # ROUTE ALL PAGE NOT FOUND TO 404
  #match "*a" => 

end
