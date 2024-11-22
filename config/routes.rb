Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  namespace :api do
    namespace :v1 do
      resources :products, except: :show
      get "/products/search" => "products#show", as: "products_show"
    end
  end

  # Defines the root path route ("/")
  root "home#index"

  get '*path', to: 'home#index', constraints: ->(req) { !req.xhr? && req.format.html? }  
end
