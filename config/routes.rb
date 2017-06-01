Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  #remove registration page
  devise_scope :user do
    resource :users,
    only: [:edit, :update, :destroy],
    controller: 'devise/registrations',
    as: :user_registration do
      get 'cancel'
    end
  end

  mount Ckeditor::Engine => '/ckeditor'
  root to: 'pages#home'
  get "category", to: "pages#home_by_category", as: :home_by_category
  get 'view', to: 'pages#view'

  resources :articles

  resources :categories, except: [:show]

  # scope format: false do
  #   get '/*id', to: 'articles#show'
  # end

end
