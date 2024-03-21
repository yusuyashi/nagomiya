Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'

}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

root to: "public/homes#top"

namespace :public do
  # 他のルーティング設定
  get '/about', to: "homes#about", as: 'about'
  resources :therapists, only: [:index]
  resources :customers, only: [:show]
  get '/information/edit', to: 'customers#edit', as: 'edit_customer'
  patch '/information/update', to: 'customers#update', as: 'update_customer'
  get '/confirmation', to: "customers#confirmation", as: 'customers_confirmation'
  patch '/withdrawal', to: 'customers#withdrawal', as: 'customers_withdrawal'
  resources :service_menus, only: [:index]
  resources :reservations, only: [:new, :create, :update] do
    member do
      get 'confirm'
      get 'complete'
      get 'thanks'
    end
  end
  resources :reservations_details, only: [:index, :show]
  resources :reviews, only: [:index, :new, :create]
end

devise_scope :customer do
  post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
end


namespace :admin do
  root to: "homes#top"
  
  resources :therapists
  resources :customers, only: [:index, :show, :edit, :update]
  resources :service_menus
  resources :reservations_details, only: [:index, :show, :destroy]
  resources :reviews
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
