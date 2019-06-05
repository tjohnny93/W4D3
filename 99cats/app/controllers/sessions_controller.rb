class SessionsController < ApplicationController
  def new
    @session = Session.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username], params[:user][:password]
    )
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end

  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    redirect_to users_url
  end

end