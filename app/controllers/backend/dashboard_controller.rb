class Backend::DashboardController < ApplicationController

  layout 'backend'
  
  before_filter :authenticate_backend
  before_filter :authorize_developer
  before_filter :deny_api
  
  def show
    @title = "Dashboard"
    @backend_user = current_backend_user
    
  end
  
  def create 
  end
  
  protected
  
end
