class UsersController < ApplicationController

  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, except: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else

      flash.now[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def destroy

  end

  def edit

  end

  def update

  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
