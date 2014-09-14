class Gnoibox::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_gnoibox_gnoibox_author!

  # layout 'gnoibox/application'

private
  helper_method :gnb_current_author, :gnb_admin?

  def gnb_current_author
    current_gnoibox_gnoibox_author
  end
  
  def gnb_admin?
    gnb_current_author.try(:is_admin?)
  end

end
