class UserController < ApplicationController
    before_action :find_user, only:[:show, :edit, :update, :destroy]

    def show;end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "SUCCESSFULLY CREATED USER!"
            redirect_to '/account'
        else
            flash.now.alert = "Invalid Email or Password"
            redirect_to  '/signup'
        end
    end


    private


    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:users).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
