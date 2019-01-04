module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController


    def google_oauth2
      @user = User.from_omniauth(request.env["omniauth.auth"])

      # if user is signed_up, sign in the user using devise (uid as the pwd)
      if @user.persisted?
        sign_in @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
        binding.pry
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        binding.pry

      end
      redirect_to '/'
    end

  end
end