Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  # for letter opener web
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
