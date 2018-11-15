Rails.application.routes.draw do
  get "static_pages/:id", to: "static_pages#show", as: :pages
  get "bundles/:id", to: "bundles#show", as: :bundles
  get "bazaarvoice_submit", to: "reviews#generate_bazaarvoice_javascript"
  get "products/:product_id/reviews/new", to: "reviews#new", as: :new_product_review
  post "products/:product_id/reviews", to: "reviews#create", as: :product_reviews
end
