Rails.application.routes.draw do
  # トップページ
  root  'events#top'

  # resource: id付のパスがなし
  # resources: id付のパスがあり
  resources :events, only: [:show, :index] do
    # topページへのルーティングを追加
    collection do
      get :top
      get :greeting
    end
    # resourceと単体になっていることに注意
    resource :event_joins, only: [:create, :destroy]
  end

  # devise for controllersでdeviseのcontrollerを適用できるようになる
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  # WARN: コントローラ名#アクション名  ✖ devise#アクション名
  devise_scope :user do
    # TIPS: ユーザー登録しっぱいのリダイレクトのエラーを防ぐ https://github.com/heartcombo/devise/blob/master/app/controllers/devise/registrations_controller.rb
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
    get 'users/destroy', to: 'users/sessions#destroy'
    get 'users/welcome/:redirect', to: 'users/registrations#welcome', as: :new_user_welcome
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users, only: [:show, :edit, :update]
end
