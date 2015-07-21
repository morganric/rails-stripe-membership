class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])


		auth = request.env["omniauth.auth"]
		@user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

		if @user.persisted?
		  sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
	      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	    else
	      session["devise.facebook_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end

	end

	def stripe_connect
    # Delete the code inside of this method and write your own.
    # The code below is to show you where to access the data.
    # raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
   	@user = current_user

   	@user.stripe_secret_key = auth.credentials.token
   	@user.stripe_publishable_key = auth.extra.raw_info.stripe_publishable_key


   	@user.save
   	redirect_to root_path

  end

end