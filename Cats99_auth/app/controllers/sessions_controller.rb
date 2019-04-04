class SessionsController < ApplicationController

before_action :require_logged_out, only: [:new, :create]
before_action :require_logged_in, except: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["INVALID CREDENTIALS"]
      render :new
    end
  end
  
  def destroy
    logout!
    redirect_to new_session_url
  end
  
end
