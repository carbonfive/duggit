Duggit::Application.routes.draw do

  root :to => 'home#index'

  resources :users
  resource :user_session
  resources :links do
    resources :votes
  end
end
