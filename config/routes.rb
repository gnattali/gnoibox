Gnoibox::Engine.routes.draw do
  root 'site#index'

  namespace :gnoibox, module: false do
    # devise_for :users, class_name: "MyEngine::User", module: :devise
    devise_for :gnoibox_author, class_name: 'Gnoibox::Author'
    resources :boxes do
      resources :items
    end
    resources :blocks

    root 'dashboard#index'
  end

  get ':first(/:second(/:third))' => 'site#index', as: :gn
end
