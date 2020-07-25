Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # we are going to list our resources here
    namespace :v1 do
      resources :users, only: %i[show create]
    end
  end
end
