class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #protect_from_forgery
  before_filter :authenticate_user!

  #include TimeHelper

  #enable_authorization(:unless => :access_without_authorization?) do |exception|
  #  render :file => "#{Rails.root}/public/403.html", :layout => false, :status => 403
  #end

 

  private
  
  def access_without_authorization?
    devise_controller?
  end
end

