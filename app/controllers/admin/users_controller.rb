class Admin::UsersController < ApplicationController
 
 def index
    @users = User.all.page(params[:page]).per(1)
  end
end