Rails.application.routes.draw do
  resources :projects
  resources :profiles
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  mount Payola::Engine => '/payola', as: :payola
  
  mount Upmin::Engine => '/admin'

  get 'products/:id', to: 'products#show', :as => :products
  get '/profiles/:id/:tag', to: 'profiles#tag', :as => :tag

  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    put 'change_plan', :to => 'registrations#change_plan'
  end
  resources :users

 

  scope ":id" do
    get '', to: 'profiles#show', :as =>  :vanity_profile
  end

  authenticated :user do
    root to: "projects#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "visitors#index"
  end

     constraints(Subdomain) do  
     get '/' => 'profiles#show', via: [:get, :post]
  end 


end
