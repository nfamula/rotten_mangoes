class Admin::UsersController < ApplicationController
 
 def index
    @users = User.all.page(params[:page]).per(1)
  end

  #def destroy_user
	#end
end