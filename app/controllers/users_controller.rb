class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Obrigado por se registrar!'
      redirect_to controller: :orders, action: :new
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_digest)
  end
end