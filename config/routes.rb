Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  get 'docker_instances/:id/log' => 'docker_instances#log'

  post 'docker_instances/log' => 'docker_instances#process_log'
  resources :docker_instances
  root to: 'docker_instances#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users
end
