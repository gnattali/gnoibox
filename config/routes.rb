Gnoibox::Engine.routes.draw do
  root 'site#index'

  namespace :gnoibox, module: false do
    # devise_for :gnoibox_author, class_name: "Gnoibox::Author", module: :devise
    devise_for :gnoibox_author, class_name: 'Gnoibox::Author'
    resources :authors
    resources :boxes do
      resources :items
    end
    resources :blocks

    get 's3' => 's3#url'

    root 'dashboard#index'
  end

  get ':first(/:second(/:third))' => 'site#index', as: :gnb
  post ':first(/:second(/:third))' => 'site#create_inquiry'
end
