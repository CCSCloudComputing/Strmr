class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url # TODO
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
