Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  if Rails.application.secrets["server_mode"] == "api"
    namespace :v1 do
    	post 'login' => 'users#social_login' # 로그인
      get 'stores' => 'stores#index' # 가맹점 목록
      get 'stores/:id' => 'stores#show' # 가맹점 상세보기
      get 'menus/:id' => 'menus#show' # 메뉴 상세보기
      post 'stores/:store_id/reviews' => 'reviews#create' # 평가하기
      get 'stores/:store_id/reviews' => 'reviews#index'
      post 'reviews/:id/evaluate' => 'reviews#evaluate'
      get 'notices' => 'notices#index'
      get 'qnas' => 'qnas#index'
      post 'qnas' => 'qnas#create'
    end
  elsif Rails.application.secrets["server_mode"] == "admin"
    scope module: :admin do
      root to: "users#index"
      resources :users
      resources :curations
      resources :stores do
        resources :menus
        resources :happyhours do
          get "bulk_edit", on: :collection
          post "bulk_update", on: :collection
          post "set_holiday", on: :collection
        end
      end
      resources :store_images, only: [:create]
      resources :menu_images, only: [:create]

      get "/login" => "sessions#new"
      post "/login" => "sessions#create"
      delete "/logout" => "sessions#destroy"

      resources :notices
    end
  end
end
