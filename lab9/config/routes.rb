Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'input#index'
  get '/input/answer', to: 'input#answer'
  get 'input/index'
  get 'input/answer'
end
