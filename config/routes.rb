Docs::Application.routes.draw do
  mount RailsAdmin::Engine => '/app_admin', :as => 'rails_admin'
  devise_for :users
  comfy_route :cms_admin, path: '/site_admin'

  authenticated do
    root to: 'home#loggedin', as: :autenticated_root
  end

  root to: 'comfy/cms/content#show'


  resources :revises do
    member do
      get :fix
      get :unfix
      get :download
    end
  end

  get 'invoices', to: 'documents#invoices'
  get 'delivers', to: 'documents#delivers'

  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    delete '/logout' => 'devise/sessions#destroy'
  end

  resources :nomenclatures do
    get :archived, on: :collection
  end
  resources :distributors, except: :show
  resources :documents, only: [:show, :edit, :update, :destroy] do
    member do
      get :download
    end
  end
  resources :orders do
    resources :documents, only: [:new, :create]
    member do
      get :accept
      get :pay
      get :ship
      get :unaccept
      get :unpay
      get :unship
    end
  end

  resources :messages do
    member do
      get :reply
      get :download
      get :sdestroy
    end
  end
  get 'outbox', to: 'messages#outbox'
  get '/docs/get/:id' => 'orders#download'

  get '/prices/:id' => 'prices#show', defaults: { format: 'json' }

  # Make sure this routeset is defined last
  comfy_route :cms, path: '/', sitemap: false


end
