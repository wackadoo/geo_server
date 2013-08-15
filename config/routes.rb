GeoServer::Application.routes.draw do
  scope "/geo_server" do
    scope "(:locale)", :locale => /en|de/ do   
      
      namespace :backend do
        resource  :dashboard, :controller => 'dashboard', :only => [:show, :create]
        resources :users 
      end
      
      namespace :fundamental do
        resources :characters
        resources :daily_position_stats
        resources :character_positions
      end

      namespace :action do
        namespace :fundamental do
          resources :log_geo_position_actions, :only => [ :create ]
        end
      end

      resource :action, :only => [ :show ]
      
      resources :sessions, :module => :auth,    :only => [:new, :create, :destroy] # staff login to backend

      root :to => 'auth/sessions#new'             # redirect to signin
    
      match '/signin',  :to => 'auth/sessions#new'
      match '/signout', :to => 'auth/sessions#destroy'
    end    
  end
end
