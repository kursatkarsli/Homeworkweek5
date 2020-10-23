class UsersController < ApplicationController
  
  def index
    @user = User.find_by_id(params[:id])
    @books = Book.where(status: true,user_id: @user) 
  end
end
