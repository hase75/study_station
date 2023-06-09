Rails.application.routes.draw do

  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'customers/my_page', to: 'customers#show'
    get 'customers/infomation/edit', to: 'customers#edit'
    patch 'customers/information', to: 'customers#update'
    get 'customers/confirm', to: 'customers#confirm'
    patch 'customers/withdraw', to: 'customers#withdraw'
    resources :spaces, only: [:index, :show] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :favorites, only: [:index]
    resources :reviews, only: [:new, :create, :update, :destroy]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'customers#index'
    resources :spaces, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :reviews, only: [:destroy]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
