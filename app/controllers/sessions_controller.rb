class SessionsController < ApplicationController
	def new

    end

	def login
		user = User.where(email: params[:email])[0]
		
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/users/#{session[:user_id]}"

		else @user
			flash[:email] = "Invalid combination"
			redirect_to "/sessions/new"
		end
	end

    def raise_not_found
        # raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
        # render text: "not found"
    end
end
