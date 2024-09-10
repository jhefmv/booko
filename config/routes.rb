Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # API
  get "isbn/:isbn", to: "isbn#show", defaults: { format: "json" }
  post "isbn/convert", to: "isbn#convert", defaults: { format: "json" }

  # book info by isbn
  get "book/:isbn", to: "books#show"

  # convert
  get "pages/isbn-convert", to: "pages#isbn_convert"

  # catch all, redirect missing routes to home
  match "*unmatched", to: "application#page_not_found", via: :all
end
