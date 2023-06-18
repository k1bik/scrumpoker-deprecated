# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource  :user, only: %i[show update edit]
  resources :rooms

  post   '/reset_estimates',  to: 'estimates#reset_estimates'
  post   '/toogle_estimates', to: 'estimates#toogle_estimates'
  post   '/toogle_hidden',    to: 'user_room_relationships#toggle_hidden'
  put    '/set_estimate',     to: 'estimates#set_estimate'
  delete 'exit_room',         to: 'rooms#exit_room'
  delete 'remove_avatar',     to: 'users#remove_avatar'

  root 'rooms#index'
end
