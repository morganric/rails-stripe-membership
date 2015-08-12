Rails.application.routes.draw do


 
  constraints(Subdomain) do  
    get '/cv', to: 'sites#cv', :as => :site_cv
    get '' => 'sites#profile', via: [:get, :post]  , as: :site_profile
    get '/project/:id', to: 'sites#project', via: [:get, :post], as: :site_project
    get '/tagged/:tag', to: 'sites#tag', via: [:get, :post], :as => :site_tag
    get '/category/:category_id', to: 'sites#category', via: [:get, :post], :as => :site_category
    get '/about', to: 'sites#about', :as => :site_about
    get '/embed', to: 'sites#media', :as => :site_embed
    get '/media', to: 'sites#media', :as => :site_media
    # get '/cv', to: ' sites#cv', :as => :site_cv
  end

    mount Attachinary::Engine => "/attachinary"
  

  resources :items

    get '/popular', to: 'projects#popular', :as => :popular
  get '/random', to: 'projects#random', :as => :random
  get '/featured', to: 'projects#featured', :as => :featured


  resources :categories
  resources :projects
 resources :profiles
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  mount Payola::Engine => '/payola', as: :payola
  mount Upmin::Engine => '/admin'



  get 'products/:id', to: 'products#show', :as => :products
  

  devise_for :users, :controllers => { :registrations => 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    put 'change_plan', :to => 'registrations#change_plan'
  end

 
  resources :users

get '/beta', to: 'visitors#index', as: :beta

   scope ":id" do
    
    get '/', to: 'profiles#feed', :as =>  :vanity_profile

  end 

  get ':user_id/project/:id', to: 'projects#show', as: :vanity_project
  get ':user_id/tagged/:tag', to: 'profiles#tag', :as => :vanity_tag
  get ':user_id/category/:category_id', to: 'profiles#category', :as => :vanity_category
  get ':user_id/about', to: 'profiles#about', :as => :vanity_about
  get ':user_id/cv', to: 'profiles#cv', :as => :vanity_cv
  get ':user_id/popular', to: 'profiles#popular', :as => :vanity_popular
  get ':user_id/random', to: 'profiles#random', :as => :vanity_random
  get ':user_id/feed', to: 'profiles#feed', :as => :vanity_feed
   get ':user_id/latest', to: 'profiles#show', :as => :vanity_latest
  get ':user_id/admin', to: 'projects#admin', :as => :admin 

  get '/tagged/:tag', to: 'projects#tag', :as => :tag




  authenticated :user do
    root to: "projects#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "projects#index"
  end




end
