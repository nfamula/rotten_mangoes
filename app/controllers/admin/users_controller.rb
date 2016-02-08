class Admin::UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page]).per(1)
  end

  def show
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    # Tell the UserMailer to send a email after delete
    UserMailer.delete_email(@user).deliver
    #delete the user
    @user.destroy && @user.reviews.destroy
    #go back to the users page
    redirect_to admin_users_path
  end
end
