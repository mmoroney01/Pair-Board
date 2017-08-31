class UsersController < ApplicationController

  def new
    @user = User.new
    render 'new'
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def show
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone)
  end

end
