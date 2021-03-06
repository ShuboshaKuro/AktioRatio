class UsersController < ApplicationController
    before_filter :authorize, :except => [:create, :new]

    def index
        @is_notif = User.find(session[:user_id]).notification
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:username, :email, :password, :password_confirmation))
        @user.notification = false

        if @user.save
            redirect_to '/'
        else
            render 'new'
        end
    end

    def update
        user = User.find(session[:user_id])
        user.update_attribute(:email, params[:email]) if params[:email] != ""
        user.update_attribute(:notification, params[:notification] == "true")

        redirect_to user_path
    end
end
