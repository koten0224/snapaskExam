Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, controllers: {
    registrations: 'user/registrations'
  }
  resources :tutorials
  mount Api::ApiRoot => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
