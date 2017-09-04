class UsersController < ApplicationController

  def new
    @user = User.new
    render 'new'
  end

  def create
    @user = User.new(user_params)

    if @user.save
      params[:user_id] = @user.id
      redirect_to '/'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if session[:user_id] == @user.id
      @user.topics = user_topics(user_profile_params)
      @user.update_attributes(user_profile_params)
      @user.valid?
      if @user.valid?
        # a paperclipped photo can be deleted
        # @user.avatar = nil
        # @user.save
        render "show"
      else
        render "edit"
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    render "edit"
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :picture_url, :email, :password, :phone, :avatar)
  end

  def user_profile_params
    params.require(:user).permit(:avatar, :picture_url, :bio, :topic1, :topic2, :topic3)
  end
end
