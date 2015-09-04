class Web::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    authentication = Authentication.from_omniauth(auth)
    
    user_info = auth.extra.raw_info.slice(:email, :first_name, :last_name, :gender)
    @user = authentication.user || User.create(email: user_info[:email], 
      first_name: user_info[:first_name], 
      last_name: user_info[:last_name], 
      gender: user_info[:gender], 
      authentications: [authentication])
    
    if @user.persisted?
      sign_in_and_redirect @user 
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end