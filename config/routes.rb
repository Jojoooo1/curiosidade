Rails.application.routes.draw do

  devise_for :users, skip: [:registrations]

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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'view', to: 'pages#view'

  resources :articles
  resources :categories, except: [:show]

  # scope format: false do
  #   get '/*id', to: 'articles#show'
  # end

end
