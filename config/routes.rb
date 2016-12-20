ShiftCommerce::Engine.routes.draw do
  get "static_pages/:id", to: "static_pages#show", as: :pages
end
