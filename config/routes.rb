Secom::Application.routes.draw do
  root :to => "reports#main"

  get "reports/main"
  get "reports/funds"
  post "reports/funds"

  resources :branches
  resources :expenses
  resources :holes
  resources :sources
  resources :payments
  resources :payment_dates

  resources :students do
    resources :payments

    member do
      get 'activate'
      get 'deactivate'
    end
  end

  resources :groups do
    resources :students

    member do
      get 'activate'
      get 'deactivate'
    end
  end

  match 'groups/show_student/:student_id' => 'groups#index'

  resources :levels
  resources :teachers
  resources :course_times
  resources :lessons
  resources :rooms

  devise_for :users
  devise_for :participants, :class_name => "Ort::Participant"


  namespace :ort do
    root :to => "exams#index"

    resources :exam_types, :payments
    resources :cheques do
      resources :payments
    end

    resources :participants do
      get 'exams', :on => :member
      get 'password', :on => :member
      post 'password', :on => :member

      resources :payments, :cheques
    end

    resources :exams do
      get 'participants', :on => :member

      resources :payments, :cheques
    end
  end

  match "ort_results" => "ort::participants#show_mark"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
