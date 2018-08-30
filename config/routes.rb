Rails.application.routes.draw do
  get "static_pages/:id", to: "static_pages#show", as: :pages
  get "bundles/:id", to: "bundles#show", as: :bundles
end
