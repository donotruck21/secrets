class SecretsController < ApplicationController

	before_action :require_login, only: [:index, :create, :destroy]

	def index
		@all_secrets = Secret.all
		@user_id = session[:user_id]
	end

	def create
		User.find(session[:user_id]).secrets.create(content: params[:secret])

		redirect_to "/users/#{session[:user_id]}"
	end

	def destroy
		secret = Secret.find(params[:secret_id])
		secret.destroy if secret.user == current_user
		redirect_to "/users/#{session[:user_id]}"
	end
end
