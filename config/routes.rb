BowlingOnRails::Application.routes.draw do
  root :to => 'application#index'

  resources :games do
  end
end
