Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    # devise_for :users
    # devise_for :users, :controllers => { registrations: 'registrations' }
    devise_for :users, :controllers => { registrations: 'users/registrations' }

    resources :categories
    resources :acts

    get 'stats', to: 'stats#index'
    post 'stats-filter', to: 'stats#filter'

    root 'acts#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
