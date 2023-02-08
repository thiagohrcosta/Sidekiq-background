Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users
  root to: "pages#home"

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
