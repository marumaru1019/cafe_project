Rails.application.routes.draw do
  root  'hello#index'  #この1行を追加
  get 'hello/index', to: 'hello#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'hello/create', to: 'hello#create'
end
