TrackerV1::Application.routes.draw do

  #Landing page
  root 'homes#index'

  get 'new_contact' => 'homes#new_contact'
  get 'about_us' => 'homes#about_us'
  get 'terms_of_use' => 'homes#terms_of_use'
  match 'check_paperclip' => 'homes#check_paperclip', via: [:get, :post]
  match 'save_contact' => 'homes#save_contact', via: [:post]
  resources :homes ,only: [:index]

  resources :shipments, except: [:destroy] do
    get :autocomplete_address_client, :on => :collection
  end
  get 'print_by_date' => 'shipments#print_by_date'
  match 'admin/print-page' => 'admin#print_pages_history', via: [:get, :post]
  match 'print-page' => 'shipments#print_pages', via: [:get, :post]
  get 'reporting' => 'shipments#reporting'
  get 'manifest' => 'shipments#manifest'
  get 'address_listing' => 'shipments#address_listing'
  get 'tracking' => 'shipments#tracking'
  get 'details' => 'details#create'

  match 'shipment_track' => 'shipments#track', via: [:get, :post]
  match 'shipment_pickup' => 'shipments#pickup', via: [:get, :post]
  match 'shipment_deliver' => 'shipments#deliver', via: [:get, :post]


  get "admin/index"
  get "admin/shipment_history"
  get "admin/today_shipments"
  get "admin/action_by_admin"
  post "admin/set_cut_off_time"
  get "admin/login_as_user"
  get "admin/user_onoff_flag"
  get "admin/show_signature"
  get "admin/make_user_admin"
  get 'admin/user_shipment_history'
  match 'admin/back_to_account' => 'admin#back_to_account', via: [:get, :post]
  match 'admin/add_note_to_user' => 'admin#add_note_to_user', via: [:get, :post]
  get "admin/new_release" => 'admin#new_release', :as => :new_release

  devise_for :users, :controllers => {:registrations => "registrations", :passwords => "passwords"}
end
