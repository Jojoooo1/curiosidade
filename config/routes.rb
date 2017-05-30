Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'view', to: 'pages#view'

  resources :articles

  scope format: false do
    get '/*id', to: 'articles#show'
  end

end
