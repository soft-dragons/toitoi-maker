Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'

  resources :problems, only: [:new, :edit, :show]
  get 'myProblem' => 'problems#myProblem'
  get 'test' => 'problems#test'
  get 'toitoi' => 'problems#toitoi'

end
