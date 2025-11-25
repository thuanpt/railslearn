Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # Trang chủ - khi truy cập "/" sẽ gọi PagesController#home
  root "pages#home"
  
  # Routes cho các trang tĩnh
  get "about", to: "pages#about"    # /about -> PagesController#about
  get "contact", to: "pages#contact" # /contact -> PagesController#contact
  
  # RESTful routes cho Articles
  # resources tự động tạo 7 routes: index, show, new, create, edit, update, destroy
  resources :articles
  
  # Cách viết khác (tương đương):
  # get "about" => "pages#about"
  # get "/about", to: "pages#about", as: :about_page
end
