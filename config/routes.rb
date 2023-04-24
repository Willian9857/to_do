Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :to_dos, format: 'json'
    end
  end
end
