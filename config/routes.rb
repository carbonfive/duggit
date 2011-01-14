Duggit::Application.routes.draw do

  root :to => 'home#index'

  resource :users
end
