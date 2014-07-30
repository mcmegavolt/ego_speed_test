Rails.application.routes.draw do
  
  root 'home#index'

  resources :comments
  resources :records
  resources :users

  get 'populator/new' => 'populator#new', :as => :populate_form
  post 'populator/populate' => 'populator#populate', :as => :populate
  post 'populator/drop' => 'populator#drop', :as => :drop
  

end
