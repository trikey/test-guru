Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }, controllers: { registrations: 'registrations' }

  resources :users, only: :create
  resources :sessions, only: :create
  resources :badges, only: :index
  get '/badges/my', to: 'badges#my', as: 'my_badges'

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  get '/contacts', to: 'contacts#index', as: 'contacts'
  post '/contacts', to: 'contacts#submit'

  namespace :admin do
    resources :badges
    resources :tests do
      patch :update_inline, on: :member
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end

    resources :gists, only: :index
  end
end
