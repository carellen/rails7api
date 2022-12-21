subdomain = Rails.env.production? ? ENV['API_SUBDOMAIN'] : 'api'

Rails.application.routes.draw do
  # api documentation, visit /apidocs
  apipie

  namespace :api, defaults: { format: :json }, constraints: ({ subdomain: subdomain } if subdomain.present?), path: '/' do
    scope module: :v1, constraints: Constraints::Api.new(version: 1, default: true) do
      # public lists
      resources :lists, only: %i[index show]
      # users lists
      namespace :users do
        resources :lists do
          resources :list_items, only: %i[create update destroy]
        end
      end
      resource :login, controller: :login, only: %i[create destroy]
      resources :users
    end
  end

  match '*unmatched', to: 'application#route_not_found', via: :all
end
