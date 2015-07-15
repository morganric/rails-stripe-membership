Rails.application.routes.draw do



  resources :categories
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

  scope ":id" do
    get '/', to: 'profiles#show', :as =>  :vanity_profile

  end 
 
  constraints(Subdomain) do  
     get '' => 'sites#profile', via: [:get, :post]  , as: :site_profile
    get '/project/:id', to: 'sites#project', via: [:get, :post], as: :site_project
    get '/tagged/:tag', to: 'sites#tag', via: [:get, :post], :as => :site_tag
    get '/category/:category_id', to: 'sites#category', via: [:get, :post], :as => :site_category

  end


  get ':user_id/project/:id', to: 'projects#show', as: :vanity_project
  get ':user_id/tagged/:tag', to: 'profiles#tag', :as => :vanity_tag
  get ':user_id/category/:category_id', to: 'profiles#category', :as => :vanity_category

  



  authenticated :user do
    root to: "projects#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "visitors#index"
  end



end
