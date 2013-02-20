Eplus::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  #root :to => "home#index"
  root :to => redirect("/users/sign_in")
#  devise_for :users
devise_for :users do
  get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
end
  resources :users
  resource :users do
  	post 'do_reset_password'
	end
  
  
  resources :nfers
  resources :statuses
  resources :submissions
  resources :religions
  resources :forms
  resources :students
  resources :postcodes
  resources :genders
  resources :dayboards
  resources :curriculums
  resources :counties
  resources :schools
  
  match 'import_nfers' => 'nfers#import', :as => :import_nfers
  match 'import_students' => 'students#import', :as => :import_students
  match 'import_users' => 'users#import', :as => :import_users
  
  match 'data' => 'home#data', :as => :data
  match 'about' =>'home#about', :as => :about
  match "clean_up" => "nfers#clean_up"
  
end