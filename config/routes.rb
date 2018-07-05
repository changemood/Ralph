Rails.application.routes.draw do
  root to: "home#index"

##########################################################API
scope module: :api, defaults: { format: :json } do
  namespace :v1 do
    devise_scope :user do
      post '/users', to: 'users/registrations#create'
      post '/users/sign_in', to: 'users/sessions#create'
      get  '/users/confirmation', to: 'users/confirmations#show'
      post '/users/confirmation', to: 'users/confirmations#create'
      patch  '/users/password', to: 'users/passwords#update'
      post '/users/password', to: 'users/passwords#create'
    end
    # Oauth
    post '/users/google', to: 'users/oauth#google'
    resources :boards do
      resources :cards do
        collection do
          get :tree
        end
      end
    end
    resources :cards do
      member do
        patch :update_ancestry
      end
      collection do
        get :review_cards
      end
    end
 end
end

########################################################## WEB
# For WEB, we should have routes only for admin usage in the future...
  # Better routes for sign_in and sign_up
  as :user do
    get 'sign_in', to: 'devise/sessions#new'
    post 'sign_in', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
    get 'sign_up', to: 'devise/registrations#new'
    get 'user', to: 'devise/registrations#edit'
  end
  devise_for :users, controllers: {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :boards do
    resources :cards
  end
  resources :cards do
    member do
      patch :update_ancestry
    end
  end

  # for sidekiq dashboard
  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"

  # for letter opener web
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
