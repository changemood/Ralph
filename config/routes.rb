Rails.application.routes.draw do
  root to: "home#index"

  # Better routes for sign_in and sign_up
  as :user do
    get 'sign_in', to: 'devise/sessions#new'
    post 'sign_in', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
    get 'sign_up', to: 'devise/registrations#new'
    get 'user', to: 'devise/registrations#edit'
  end
  devise_for :users

  resources :boards do
    resources :cards
  end
  resources :cards do
    member do
      put 'update_ancestry'
    end
  end

  # for sidekiq dashboard
  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"

  # for letter opener web
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
