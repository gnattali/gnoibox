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
    resources :forms do
      resources :inquiries
    end

    resource :profile

    resources :s3 do
      collection do
        get 'put_url'
      end
    end

    resources :stations
    
    root 'dashboard#index'
  end
  
  get 'search' =>'site#search'

  get 'thanks/:first(/:second(/:third))' => 'site#thanks', as: :gnb_thanks
  get ':first(/:second(/:third))' => 'site#index', as: :gnb
  post ':first(/:second(/:third))' => 'site#create_inquiry'
end
