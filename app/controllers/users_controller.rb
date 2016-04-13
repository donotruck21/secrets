class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	
	def show
		@user = User.find(params[:id])
		@my_secrets = User.find(params[:id]).secrets
		@all_secrets = Secret.all
	end

	def new

	end

	def create
		user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

		if user.errors.full_messages.empty?
			session[:user_id] = user.id
  			redirect_to "/users/#{session[:user_id]}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/users/new"
		end
	end

	def edit
		@user = User.find(params[:id])
	end


	def update
		User.find(params[:id]).update(name: params[:name], email: params[:email])
		redirect_to "/users/#{params[:id]}"
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to "/logout"
	end


	def logout
		session.clear
		redirect_to "/sessions/new"
	end
end
