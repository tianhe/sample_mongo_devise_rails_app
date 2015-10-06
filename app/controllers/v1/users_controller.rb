class V1::UsersController < V1::ApiController    
  before_filter :find_record, only: [:show, :update]
  skip_before_filter :authenticate_user_from_token!, only: :create

  def show
  end

  def update
    @success = @current_user.update(user_params)
    @success ? render_200 : render_error(400, ['save failed']) 
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :birthdate, :drinking_habit)
  end

  def find_record
    begin 
      @current_user = User.find(params[:id])
    rescue
      render_error(401, ['unknown user'])
    end
  end
end
