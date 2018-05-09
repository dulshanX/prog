Rails.application.routes.draw do
  root to: 'lab11#input'

  get 'lab11/input'

  get 'lab11/view'

  get 'lab11/result_in_xml'

  get '/.' => redirect('lab11/input')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
