class Web::ApplicationController < ApplicationController
  helper_method :current_user
  
  private
  
  def current_user
    user_id = session['warden.user.user.key'].try(:first).try(:first).try(:to_s)
    @current_user ||= User.where(id: user_id).first if user_id
  end

  def authenticate_user!
    unless current_user
      redirect_to :root
    end
  end
end