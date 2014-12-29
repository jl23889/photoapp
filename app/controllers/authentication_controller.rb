class AuthenticationController < ApplicationController
	def sign_in
		@user = User.new
	end

	def login
		username = params[:user][:username]
		password = params[:user][:password]
		@user = User.authenticate(username,password)

		if @user
			session[:user_id] = @user.id.to_s
			redirect_to :root
		else  
			render action: "sign_in"
		end
	end

	def new_user 
		@user = User.new
	end

	def register
		# if User.find_by(username: params[:user][:username]).nil?
			@user = User.new(user_params)

			if @user.valid?
				@user.save
				session[:user_id] = @user.id.to_s
				redirect_to :root
			else 
				render action: "new_user"
			end
	end

	def log_out
		session[:user_id] = nil
	end

	private

  def user_params
  	params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
