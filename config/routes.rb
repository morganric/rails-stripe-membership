Rails.application.routes.draw do
  resources :projects
  resources :profiles
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  mount Payola::Engine => '/payola', as: :payola
  
  mount Upmin::Engine => '/admin'

  get 'products/:id', to: 'products#show', :as => :products
  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    put 'change_plan', :to => 'registrations#change_plan'
  end
  resources :users



  constraints(Subdomain) do  
     get '/' => 'profiles#show', via: [:get, :post]
  end  

    root to: 'visitors#index'
end
