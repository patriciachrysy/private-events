Rails.application.routes.draw do
  resources :events, except: %i[edit update destroy]
  resources :users, only: %i[new create show]
  get '/sign_in' => 'users#sign_in'
  post '/sign_in' => 'users#sign_in'
  get '/sign_up' => 'users#new'
  get '/sign_out' => 'users#sign_out'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
