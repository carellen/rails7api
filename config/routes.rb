Rails.application.routes.draw do
  # api documentation, visit /apidocs
  apipie

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: Constraints::Api.new(version: 1, default: true) do
      resource :login, controller: :login, only: %i[create destroy]
      resources :users
    end
  end

  match '*unmatched', to: 'application#route_not_found', via: :all
end
