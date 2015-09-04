class Web::UsersController < Web::ApplicationController    
  before_action :authenticate_user!

  def edit    
  end

  def update    
    if @current_user.update(user_params)
      redirect_to profile_path
    else
      flash[:error] = @current_user.errors
    end

    render 'edit'
  end

private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
