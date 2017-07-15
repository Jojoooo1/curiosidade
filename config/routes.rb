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
  get "faq", to: "pages#faq"
  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  get "category", to: "pages#home_by_category", as: :home_by_category
  resources :articles
  get "articles/:id/view-all", to: "articles#view_all_related_article", as: :view_all_related_article
  resources :categories, except: [:show]

  # scope format: false do
  #   get '/*id', to: 'articles#show'
  # end
end
