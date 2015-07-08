Rails.application.routes.draw do
  resources :categories, only: [:index]
  resources :words, only: [:index]
  resources :lessons
  resources :users, only: [:index, :create, :new, :edit]
  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    root "users#index"
    resources :users
    resources :categories
    resources :words
  end

  root                     "static_pages#home"
  get     "help"       =>   "static_pages#help"
  get     "about"      =>   "static_pages#about"
  get     "contact"    =>   "static_pages#contact"
  get     "signup"     =>   "users#new"
  get     "login"      =>   "sessions#new"
  post    "login"      =>   "sessions#create"
  delete  "logout"     =>   "sessions#destroy"

  get     "/:name"      =>   "users#show", as: :user
  patch   "/:name"      =>   "users#update"
  get     "/:name/edit" =>   "users#edit", as: :edit
end
