class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username], params[:user][:password]
    )
    @user.reset_session_token!
    session = @user.ensure_session_token
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    end

  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

end