class LikesController < ApplicationController

	before_action :require_login, only: [:create, :destroy]
	before_action :require_correct_user, only: [:create, :destroy]


	def create
		@user = User.find(session[:user_id])
		@secret = Secret.find(params[:secret_id])

		like = Like.where(user:User.find(session[:user_id]), secret:Secret.find(params[:secret_id]))[0]

		if like
			redirect_to '/secrets'
		else
			Like.create(user: @user, secret: @secret)
			redirect_to '/secrets'
		end
	end

	def destroy
		like = Like.where(user:User.find(session[:user_id]), secret:Secret.find(params[:secret_id]))[0]
		if like
			like.destroy
			redirect_to '/secrets'
		else
			redirect_to '/secrets'
		end
	end
end
