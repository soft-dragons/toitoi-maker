Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'

  get 'myProblems' => 'problems#myProblems', as: 'myProblems'
  get 'test' => 'problems#test',             as: 'test'
  get 'test_index' => 'problems#test_index', as: 'test_index'
  get 'toitoi' => 'problems#toitoi',         as: 'toitoi'
  resources :problems do
    resources :answers, only: [:create]
    resources :feedback, only: [:create, :update, :destroy]
  end
end
